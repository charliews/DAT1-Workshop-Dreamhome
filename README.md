# Dreamhome SQL Workshop

Welcome to the Dreamhome Agency SQL Workshop. Your task is to write SQL queries to satisfy various business data requests.

## Prerequisites
- **Python 3.x**
- **pytest**: Install via `pip install pytest`

## Getting Started
1. **Initialize the Database**:  
   If this is your first time running the workshop, or if you need to reset your data to the clean state:
   ```bash
   python manage.py reset
   ```
   *This copies the clean database from `data/dreamhome.sqlite` to your working directory.*

2. **Read the Tasks**:  
   Open `tasks.md`. This file contains the instructions for each data request (e.g., "Request 1.1: List all property postcodes").

## How to Work
1. **Write SQL**:  
   Navigate to the `queries/` folder. Open the file corresponding to the request section (e.g., `queries/request-1.sql` for Requests 1.1, 1.2, etc.).
   Write your SQL query under the matching comment header:
   ```sql
   -- 1.1
   SELECT postcode FROM propertyforrent;
   ```

2. **Verify Results**:  
   Run the automated tests to check your answers:
   ```bash
   python -m pytest
   ```
   or simply:
   ```bash
   pytest
   ```
   
   - **PASS**: Your query returned the correct data.
   - **FAIL**: Your query returned different data than expected. Check the error message for a sample of the difference.
   - **MISSING**: You haven't written a query for this task yet.

## Reference
- **Schema**: See `schema.md` for a diagram of the database tables and relationships.
- **Tips**: You do not need to match the "official" SQL solution word-for-word. The grader checks your **results**.
