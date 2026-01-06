import sys
import shutil
import os
import argparse

# Configuration
DB_SOURCE = os.path.join('data', 'dreamhome.sqlite')
DB_DEST = 'dreamhome.sqlite'

def reset_db():
    """Resets the database by copying the clean binary from data/."""
    if not os.path.exists(DB_SOURCE):
        print(f"Error: Source database '{DB_SOURCE}' not found.")
        sys.exit(1)
    
    try:
        shutil.copy2(DB_SOURCE, DB_DEST)
        print(f"Database reset successfully: Copied {DB_SOURCE} to {DB_DEST}")
    except Exception as e:
        print(f"Error resetting database: {e}")
        sys.exit(1)

def run_tests():
    """Runs the SQL comparison tests using pytest."""
    try:
        # returns exit code 0 if all tests pass, 1 if some fail
        result = pytest.main(["-v", "tests/test_grading.py"])
        if result not in [0, 1]:
            print(f"Pytest exited with code {result}")
            sys.exit(result)
    except Exception as e:
        print(f"Error running tests: {e}")
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description="Dreamhome Workshop Manager")
    parser.add_argument('command', choices=['reset', 'test'], help='Command to execute: reset (restore DB) or test (grade queries)')
    
    args = parser.parse_args()
    
    if args.command == 'reset':
        reset_db()
    elif args.command == 'test':
        run_tests()

if __name__ == "__main__":
    # Import here to avoid check if just running reset
    try:
        import pytest
    except ImportError:
        print("Error: pytest is not installed. Run 'pip install pytest'.")
        sys.exit(1)
    main()
