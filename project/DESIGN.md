# Design Document

By Idris Atabo

Video overview: <URL HERE>

## Scope

In this section the following questions where answered:

* What is the purpose of your database?
  - To maintain records of users so they can be offered discounts for future orders, A database to find a variety of places
    you can order food from

* Which people, places, things, etc. are you including in the scope of your database?
  - The entities of the database are Users, Orders, drivers, deliveries, addresses, businesses, product types(food)and reviews


* Which people, places, things, etc. are *outside* the scope of your database?
  - Out of scope would be handling financial transactions data
  - The user ordering from more than two Food providers at the particular time of ordering
  - Database doesn’t provide real-time tracking of the delivery
  - The database cannot provide answers on why a driver might missed the estimated delivery time or if it’s not delivered at all (but investigations can be made)
  - This database doesn’t provide any support for loyalty programs for users


## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
  - Customers will be able to query for food they want to order
  -  Any one with access can track and confirm Order Completion
  - Food provider is able to perform CRUD operations on the database to modify their services & products
* What's beyond the scope of what a user should be able to do with your database?
  - No one can track how economic value(e.g; cash) would flow through the entire process


## Representation


### Entities

### Users
* `id` This unique id number represents each customer, it has the date type `INTEGER`, This field has the `PRIMARY KEY` constraint for each row to be unique while having the ability to be referenced from another table.
* `first_name` This field would represent the first name of the user/customer with the data type `TEXT`, it has the constraint `NOT NULL` to ensure the first name is inserted.
* `last_name` This field represents the last name of the user/customer with the data type `TEXT`, it has the constraint `NOT NULL` to ensure the last name is inserted.
* `username` This field would represent the unique username to represent the customer data type `TEXT`, it has the constraint `NOT NULL` to ensure it's inserted and `UNIQUE` to ensure there is no ambiguity.
* `password` This field represent the users password which would be used to login into the platform, it has the data type `TEXT`, it has the constraint `NOT NULL` to ensure a password is added and `UNIQUE` to ensure it's different. It has a condition to ensure that users password is equal to or above 8 characters.
* `discount_status` This field represents customer who are qualified or not qualified for the discount, using the data type `TEXT`, default values are given (`Qualified` or `Not Qualified`) and a constraint `NOT NULL` to ensure the discount status is inserted.
* `email_address` This field represents the email address with the data type `TEXT`, and the constraint `UNIQUE` and `NOT NULL` to ensure the ensure the address is inserted while being different.

### Food-Business
* `id` This field represent the unique identifier given to each food with the data type `INTEGER` this field has the `PRIMARY KEY` constraint for each row to be unique while having the ability to be referenced from another table.
* `name` This field represent the name of the company or business providing the food, it has a `TEXT` data type , it has the constraint  `UNIQUE` and `NOT NULL` to ensure there is a different provider in every row.
* `type`  This field represents the kind of business providing the food E.g Fine dining, Fast food etc, its data type is `TEXT`, it has the constraint `NOT NULL` to ensure a type is inserted .


### Food-Product
* `id` This field represents the id of the food product being offered with the data type `INTEGER`, it has the `PRIMARY KEY` constraint for each row to be unique while having the ability to be referenced from another table.
*  `business_id` This field is a foreign key referenced to the Food business id, it has the data type `INTEGER`
* `product_name` This field represents the name of the food with the data type `TEXT`, it has the constraint `NOT NULL` to ensure the name of product is inserted and the `UNIQUE` field to ensure every provider's servings are different.
* `type` This field represent types of products which are **fast-food**, **food** and **beverage** with the data type `TEXT` and a constraint `NOT NULL` to ensure a type is inserted to avoid ambiguity.
* `price` This field represent the charge for each product represented with the data type `NUMERIC` and a constraint `NOT NULL` to ensure a price is inserted.
* `extras` This field represents anything to be added with the particular food product being served by a company, this field has the data type `TEXT`.
* `preparation_duration` This field represent the time used to prepare each meal with the data type `TEXT`.
* `applicable_discount` This field represent the applicable discount to a food product with the data type `NUMERIC` and the constraint `NOT NULL` to avoid ambiguity on whether there is a discount or not.

### Orders
* `id` This field represent each row in this table with the data type `INTEGER` and it has the `PRIMARY KEY` constraint for each row to be unique while having the ability to be referenced from another table.
* `user_id` This field is a foreign key referenced to the primary key in the customer table with the data type `INTEGER`.
* `product_id` This field is a foreign key referenced to the primary key in the product table with the data type `INTEGER`.
* `product_id2` This field is also foreign key referenced to the primary key in the food product table beacuase a customer can order from two places at once, this field also has the data type `INTEGER`, it also has the constraint `DEFAULT` `NOT NULL` for an instance where a second product is not ordered.
* `quantity` This field represent the number of product being ordered with the data type `INTEGER` and the constraint `NOT NULL`
* `quantity2` This field represent the quantity of the second food products ordered, it has the data type `INTEGER` and the constrain `NOT NULL`.
* `amount` This field represent the total amount to be a paid inclusive of delivery fees, it is represented with the data type `NUMERIC`, it has the constraint `NOT NULL`.
* `description` This field represent anything the food provider is to take note of such as; allergies to certain ingredients, extra spices ETC. it has the constraint `NOT NULL`.
* `status` This field comes with the data type `TEXT` and the constraint `NOT NULL` , this field has constant values using `CHECK(`status` `IN` ("completed”, “cancelled”))`.
* `start_time` This represents the time in which the order was placed with the type `DATETIME`.
* `end_time` This represents the time in which the order was completed by the food providers with the type `DATETIME`.

### Driver
* `id` This field represents the primary key of the table with the data type `INTEGER`, it has the `PRIMARY KEY` constraint for each row to be unique while having the ability to be referenced from another table.
* `name` This field is the delivery driver’s name represented with the data type `TEXT`.

### Delivery
* `user_id` This field is a foreign key referenced to the customer table represented with the data type `INTEGER`.
* `addresses_id` This field represent the id's that is referenced from the address table, it has the data type `INTEGER`.
* `order_id` This field is a foreign key referenced to the order table, it has the data type `INTEGER`.
* `driver_id` This field is a foreign key referenced to the courier table represented with the data type `INTEGER`.
* `estimated_time` This field indicates how many minutes or hours the delivery should get to its destination represented with the data type `TEXT` and it has the constraint `NOT NULL` to ensure that an estimate time is given to reduce uncertainty in the customers nature.
* `date` This field represents the time in which the delivery process begun typically immediately when the driver receives the order from the food provider, It has type `DATETIME` attribute and constraint `NOT NULL` to ensure rows in this field are not empty

### Addresses
* `id` This field represents the unique identifier for this table, it has the data type `INTEGER` and the `PRIMARY KEY` constraint for each row to be unique while having the ability to be referenced from another table.
* `user_id` This field is a foreign key referenced from the user table, representing the user who provided the address, it has the data type `INTEGER`
* `address` This field represent the address in which a food product is to be delivered to, it has the data type `TEXT` and the constraint `NOT NULL` to ensure an address must be inserted.
* `postal_code` This Field represents the code of the area in which address is located, it has the data type `INTEGER` and the constraint `NOT NULL` to ensure a code must be inserted.

### Reviews
* `id` This field represents the primary key of the review table having the data type `INTEGER`, it has the constraint `UNIQUE` to ensure the id's are different.
* `product_id` This field is a foreign key referenced to the the primary key of the food-product table represented with the data type `INTEGER`.
* `driver_id` This field is foreign key referenced to the primary key of the driver table represented with the data type `INTEGER`.
* `product_review` This field represents the written comments on the product ordered, it has the data type `TEXT`.
* `driver_review` This field represents the written comments on the couriers timeliness and manner, it has the data type `TEXT`.


### Relationships

This section includes the entity relationship diagram and describes the relationships between the entities in the database.

![ER Diagram](https://mermaid.ink/img/pako:eNp1kmFvgjAQhv9K08XwRYzzg1G-qWBiss0F1GULian0cM2gJaWaGfC_rxRR3DJIoL17-t6b6xU4EhSwgzudIuQIMc6Ug8wSIUt9QgqWg6wdycHqtqMbIhnZJZBbV1ynMslSIk8zkQhZnXuYT-bj-bA5eiNW8K1uVN88f6mpkBTkjZu47shrqyWMQ6vYaDoYjFvpHCLB6Z2hfn_4eFdKgVTsDonj2KrT5-qnP-dOJ-TVC9JlZC9JGvJ14PmoLG27LNHSd_XGQVlCIshDPl8uXXu6DhYvXhDUUIFM8NVfuuvZqmKlODJ6pZtEWfR6Gm4UIwlEAd3GQoa8DhqiRK73tNh4_ruGFPkCXiPXaFkaHd0xv_LgoL2AfKvExfj5d_o_O5oTBfK9zcJ70xjLt3t2BN0K168KaQAZpZYdU6l20zC2fRVpa-AuTkGmhFE9gWaKQmymK8SOXlKIySFRIdY3oFFyUCI48Qg7Sh6giw8Z1b25XAh2YpLkOpoR_iHEbQ-UKSGf6yk3w37-AdfQ68U?type=png)

- Food provider **provides** one to many food products but a food product can be **provided** by one and only one food provider.
- A food product can be **created for** one to many orders and an order can be **created for** one to many food products(it is assumed that two order can be placed by only one user).
- Food product can be **given** zero to many reviews, while each review **is given** for one food product and only one food product.
- A user can **place** one order and only one order, while each order can be **placed** by one and only one user
- A user can ***provide*** one to many addresses, while an address can be **provided** by one to many users(it is taken into account that usually a user’s address for an order is temporal and is always subject to change)
- An order is **taken for** one and only one delivery, while a delivery can have multiple orders
- A driver **goes for** one to many deliveries, while a delivery is taken by one and only one driver
- A driver can be **given** zero to many reviews, while a review **is given** to one and only one driver
- a delivery **goes to** one or many addresses, while an address is given for one to multiple orders



## Optimizations

In this section the following questions where answered:

* Which optimizations (e.g., indexes, views) were created? Why?
### Views
- The user address view will aid in helping drivers query for the name of a user associated with an address
- The qualified by frequency view helps the employees ascertain what users are eligible for discounts
- The valuable user view helps to discover what are the valuable users in the database

### Indexes
- The 'examine_delivery' index is used to optimize the search speed of the order_id and address id
- The 'time_search' index is used to optimize the search speed of the start time and end time of an order, it will be used alot of times to see what order of have short or long preparation duration
- The 'user_search' index is used to optimize search speed when looking for customers names(this index is used frequently)
- The 'postal_search' index is used to search for address and postal-code as this such queries will be used recurringly during the day by drivers


## Limitations

The limitations of the database are as follows:
- The database doesn’t provide real-time tracking of the delivery
- The database doesn't take into account the flow of monetary value from the user to the businesses
- it doesn't describe or take into account where the product is going to be delivered from
- The database may have issues with ordering from two places at once
