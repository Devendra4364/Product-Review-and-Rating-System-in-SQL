# Project Review and Rating System in SQL

## Project Description
This project is a comprehensive system for managing product reviews and ratings using SQL. It allows users to submit reviews for products, and provides a structured way to store, retrieve, and manipulate review data.

## Features
- User authentication and authorization.
- Add, edit, and delete product reviews.
- Rate products on a scale (e.g., 1 to 5 stars).
- Retrieve average ratings for products.
- Search and filter reviews by various criteria (e.g., product name, rating).

## Database Schema
The database consists of the following tables:
1. **Users**: Stores user information and authentication credentials.
2. **Products**: Contains details about products being reviewed.
3. **Reviews**: Stores user-submitted reviews, ratings, and associated products.

### Users Table
| Field         | Type         | Description                    |
|---------------|--------------|--------------------------------|
| user_id      | INT          | Unique identifier for each user.
| username      | VARCHAR(255) | User's chosen username.
| password_hash | VARCHAR(255) | Hashed password for authentication.

### Products Table
| Field      | Type         | Description                       |
|------------|--------------|-----------------------------------|
| product_id | INT          | Unique identifier for each product.
| name       | VARCHAR(255) | Name of the product.
| description| TEXT         | Detailed description of the product.

### Reviews Table
| Field       | Type       | Description                           |
|-------------|------------|---------------------------------------|
| review_id   | INT        | Unique identifier for each review.
| user_id     | INT        | ID of the user submitting the review.
| product_id  | INT        | ID of the reviewed product.
| rating      | INT        | Rating given to the product (1-5).
| comment     | TEXT       | Review text provided by the user.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Devendra4364/Product-Review-and-Rating-System-in-SQL.git
   ```
2. Create a database in your SQL server.
3. Execute the SQL scripts provided in the `sql/` directory to set up database tables.
4. Configure the database connection in the project's configuration file.

## Usage
- Start the application and navigate to the product review section.
- Users can sign up, log in, and start reviewing products.
- The application will display average ratings and user reviews.

For more information, check the project's documentation.

## Contribution
Contributions are welcome! Please fork the repository and submit a pull request.