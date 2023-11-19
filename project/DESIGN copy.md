# Design Document

By Idris Atabo

Video overview: <URL HERE>

## Scope

In this section you should answer the following questions:

* What is the purpose of your database?
  - To maintain records for previous customers so they can be offered discounts for future orders, A database to find a variety of places
    you can order food from

* Which people, places, things, etc. are you including in the scope of your database?
  - The entities of the database are Order, Customers,driver, delivery, product type(food)and reviews


* Which people, places, things, etc. are *outside* the scope of your database?
  - Out of scope would be handling financial transactions data
  - Database doesn’t provide real-time tracking of the delivery
  - The database cannot provide answers on why a driver might missed the estimated delivery time or if it’s not delivered at all
  - This database doesn’t provide any support for loyalty programs for customers


## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
  - Customers will be able to query for food they want to order
  -  Any one with access can track for Order Completion
  - Food provider is able to perform CRUD operations on the database to modify their services & products
* What's beyond the scope of what a user should be able to do with your database?
 - No one can track how economic value(e.g; cash) would flow through the entire process


## Representation

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
* What attributes will those entities have?
* Why did you choose the types you did?
* Why did you choose the constraints you did?

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
 -
* What might your database not be able to represent very well?
 - The database doesn’t provide real-time tracking of the delivery
