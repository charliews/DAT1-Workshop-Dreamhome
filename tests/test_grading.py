import pytest
import sqlite3
import os
import glob
import re
import json

# Constants
DB_PATH = 'dreamhome.sqlite'
QUERIES_DIR = 'queries'
# Now we look for JSON snapshots, not SQL solutions
SNAPSHOTS_DIR = os.path.join('tests', 'snapshots')

def get_db_connection():
    if not os.path.exists(DB_PATH):
        pytest.fail(f"Database {DB_PATH} not found. Run 'python manage.py reset' first.")
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def parse_sql_file(filepath):
    """
    Parses a SQL file and extracts queries identified by comments like '-- 1.1'.
    Returns a dictionary: { "1.1": "SELECT ...", "1.2": "SELECT ..." }
    """
    if not os.path.exists(filepath):
        return {}

    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    pattern = re.compile(r'^\s*--\s*(?:Request\s*)?(\d+\.\d+).*$', re.MULTILINE | re.IGNORECASE)
    parts = list(pattern.finditer(content))
    
    queries = {}
    if not parts:
        return {}

    for i, match in enumerate(parts):
        key = match.group(1)
        start = match.end()
        
        if i + 1 < len(parts):
            end = parts[i+1].start()
            query_chunk = content[start:end]
        else:
            query_chunk = content[start:]
            
        cleaned_query = query_chunk.strip()
        if cleaned_query:
            queries[key] = cleaned_query

    return queries

def strip_extension(filename):
    return os.path.splitext(os.path.basename(filename))[0]

def pytest_generate_tests(metafunc):
    """
    Dynamically generates test cases based on available JSON snapshots.
    """
    if "task_id" in metafunc.fixturenames:
        # Load all snapshot files to define the test matrix
        snapshot_files = glob.glob(os.path.join(SNAPSHOTS_DIR, '*.json'))
        tasks = []
        
        for sf in snapshot_files:
            # Filename is the task id, e.g. "1.1.json"
            task_id = strip_extension(sf)
            tasks.append(task_id)
        
        # Sort tasks naturally
        tasks.sort(key=lambda x: [int(p) for p in x.split('.')])
        
        metafunc.parametrize("task_id", tasks)

def test_query_result(task_id):
    """
    Test case that runs for every Task ID found in snapshots.
    """
    # 1. Load Expected Data from Snapshot
    snapshot_path = os.path.join(SNAPSHOTS_DIR, f"{task_id}.json")
    if not os.path.exists(snapshot_path):
        pytest.fail(f"Snapshot for {task_id} missing (Internal Error)")
    
    with open(snapshot_path, 'r', encoding='utf-8') as f:
        expected_rows_raw = json.load(f)
    
    # Convert list of lists (JSON) to list of tuples (SQLite compatible)
    expected_rows = [tuple(r) for r in expected_rows_raw]

    # 2. Parse Student Query
    student_sql = None
    student_files = glob.glob(os.path.join(QUERIES_DIR, 'request-*.sql'))
    for sf in student_files:
        parsed = parse_sql_file(sf)
        if task_id in parsed:
            student_sql = parsed[task_id]
            break
    
    # Check if student submitted work
    if not student_sql:
        pytest.fail(f"Task {task_id}: MISSING - No query found for '-- {task_id}' in {QUERIES_DIR}/")

    # 3. Execute and Compare
    conn = get_db_connection()
    
    try:
        # Run Student Query
        # If there is a verification query for this task, we run student logic THEN verification logic
        # Verification file is at tests/verification/TASK_ID.sql
        ver_file = os.path.join(os.path.dirname(__file__), 'verification', f"{task_id}.sql")
        
        if os.path.exists(ver_file):
            conn.executescript(student_sql) # Run student modification (allow multi-statement)
            with open(ver_file, 'r', encoding='utf-8') as vf:
                ver_sql = vf.read()
            cur_stud = conn.execute(ver_sql) # Run verification
        else:
            cur_stud = conn.execute(student_sql) # Run student select

        student_rows = [tuple(r) for r in cur_stud.fetchall()]
        
        # Compare
        # Note: If order matters, this checks order. If order doesn't matter, we might need set comparison.
        # For this workshop, usually assuming order matches or is specified in problem.
        # Strict equality is safest for now.
        assert student_rows == expected_rows, (
            f"Task {task_id}: FAIL\n"
            f"Expected {len(expected_rows)} rows, got {len(student_rows)}.\n"
            f"Expected (Sample): {expected_rows[:1]}\n"
            f"Actual (Sample):   {student_rows[:1]}"
        )
        
    except sqlite3.Error as e:
        pytest.fail(f"Task {task_id}: ORACLE ERROR - {e}")
    finally:
        conn.close()
