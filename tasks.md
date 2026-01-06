# DreamHome Agency Data Requests

As a data analyst for DreamHome Agency, you've received the following data requests from various departments. Please provide the requested information using our database. 

## Instructions
1. Write your SQL query in the corresponding file in the `queries/` directory (e.g., `queries/request-1.sql`).
2. Ensure your query is written under the correct comment header (e.g., `-- 1.1`).
3. To verify your answers, run the automated test runner:
   ```bash
   python -m pytest
   ```
4. Aim for "PASS" on all checks.


## 1. Property Management Department

### Request 1.1:
We need a list of all our property postcodes for a mailing campaign.

### Request 1.2:
Provide a list of all properties and their viewing history, including those that haven't been viewed, to plan maintenance visits.

### Request 1.3:
We're considering expanding to areas with postcode starting 'BS1'. Can you confirm if we have any properties in these areas?

## 2. Client Relations Team

### Request 2.1:
Find all properties managed by client 'PO4756'. We need this for a client satisfaction survey.

### Request 2.2:
We're auditing recent client registrations. Please provide all registrations at branch 'B052' that occurred after September 28, 2013.

### Request 2.3:
Provide details of the most recent property viewing for our customer feedback initiative.

## 3. Marketing and Sales Team

### Request 3.1:
We're reaching out to property owners whose first name starts with 'C' for a special promotion. Please provide their details.

### Request 3.2:
Categorize our properties based on their rent for our new pricing strategy. Use 'Budget' for rent < 500, 'Standard' for rent between 500 and 1000, and 'Premium' for rent > 1000.

### Request 3.3:
We're creating a unified mailing list. Provide a list of all individuals (clients and private owners) associated with the agency, showing their names and type.

## 4. Finance and Investment Department

### Request 4.1:
We need a comprehensive list of all rental properties, including owner details, for our annual financial report.

### Request 4.2:
Create a report of high-value properties (those with rent higher than average) for potential investors.

### Request 4.3:
Due to increased demand, we need to increase the rent for all Manchester properties by 10%.

## 5. Operations and HR Team

### Request 5.1:
We need to know how many properties are currently managed by staff member 'SSU15' for workload assessment.

### Request 5.2:
We need a report showing the number of properties in each city, but only for cities with more than 2 properties, to focus our resources.

### Request 5.3:
Identify all staff members who manage properties with above-average rent for our annual performance reviews.

## 6. Executive and IT Department

### Request 6.1:
For our board meeting, we need a list of all cities where we either have a branch office or a property for rent, without duplicates.

### Request 6.2:
We're updating our database. Please create a new table named 'propertyreviews' to store customer feedback.

### Request 6.3:
We've collected initial reviews for some properties. Please add these to our new 'property_reviews' table.

Use the following data for insertion:

1. Property: PR1423, Client: CL7623, Review Date: 2023-05-15, Rating: 4, Comment: "Spacious and well-maintained property. Great location."
2. Property: PR9478, Client: CL5612, Review Date: 2023-05-16, Rating: 5, Comment: "Excellent modern amenities. Highly recommended!"
3. Property: PR4567, Client: CL7489, Review Date: 2023-05-17, Rating: 3, Comment: "Decent property, but needs some minor repairs."
4. Property: PR3689, Client: CL6234, Review Date: 2023-05-18, Rating: 4, Comment: "Good value for money. Nice neighborhood."
5. Property: PR2145, Client: CL7712, Review Date: 2023-05-19, Rating: 2, Comment: "Disappointing. Several issues with plumbing and heating."

### Request 6.4:
To maintain data relevance, remove all property viewings that occurred before June 1, 2013.

Please ensure all queries are optimized for performance and include appropriate error handling. Use clear aliases in your SQL to make the code readable for future maintenance.
