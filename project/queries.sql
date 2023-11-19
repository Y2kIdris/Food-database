-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

--This query is used by database administrators to derive the information about the number of users in the database
SELECT COUNT("id") AS "number_of_users" FROM "users";

--This query represent how many orders taken for delivery each day
SELECT "date", COUNT("order_id") FROM "deliveries"
GROUP BY "date";

-- This query represent an order that was cancelled by a user but it somehow was never stated
UPDATE "orders"
SET "status" = 'cancelled'
WHERE "user_id" = (
    SELECT "id"
    FROM "users"
    WHERE "first_name" = 'Idris' AND "last_name" = 'Kareem'
);

-- A user requested, she doesn't want to be associated with an address in the database as she no longer uses these addresses
DELETE FROM "addresses"
WHERE "user_id" = 1984;

--a of user's data being inserted into the users table
INSERT INTO "users" ("id", "first_name", "last_name", "username", "password", "discount_status", "email_address")
VALUES
(79, 'Kodack', 'Black', 'Koddy_u12', '123ungt*9#h', 'qualified', 'kodackblack89@yahoo.com');

-- a new business's data is inserted
INSERT INTO "food_businesses" ("id", "name", "type")
VALUES (17, 'Amala place', 'Food');

--The data entry clerk was feeling foggy and missed this entire row of a product the food business has as available so its been inserted
INSERT INTO "food_products" ("id", "business_id", "product_name", "type", "price", "extras", "preparation_duration", "applicable_discount")
VALUES
(98, 17, 'Egusi & poundo', 'food', 20, 'shaki, goat meat, roundabout & ponmo', '35 mins', -2.15);


-- a new order data is inserted into the order table
INSERT INTO "orders" ("id", "user_id", "product_id", "product_id2", "quantity", "quantity2", "amount_charged", "description", "status", "start_time",
"end_time")
VALUES
(56, 79, 98, NULL, 2, 0, 58, 'Extra mayo, Extra spice and Extra ketchup', 'completed', '2023-02-10 02:34:27', '2023-02-10 03:04:36');

-- a new driver has employed so he's data is inserted to the drivers table
INSERT INTO "drivers" ("id", "name")
VALUES
(109, 'libel');

-- A new addresses has been provided by user
INSERT INTO "addresses" ("id", "user_id", "address", "postal-code")
VALUES
(1, 79, '14 khartoum streeet', '900108');

-- delivery data being inserted into delivery table
INSERT INTO "deliveries" ("user_id", "address_id", "order_id", "driver_id", "estimated_time", "date")
VALUES
(79, 1, 56, 109, '35 minutes', '2023-03-28');

-- review data insertion
INSERT INTO "reviews" ("id", "product_id", "driver_id", "product_review", "driver_review")
VALUES
(434, 98, 109, 'The food was delicious with right amount of spice, Perfect!', 'The driver was fast and timely, the food was still
hot when he arrived');


-- This query is used to find postal code with more than 10 addresses.
SELECT "postal-code", COUNT("address") FROM "addresses"
GROUP BY "postal-code"
HAVING COUNT("address") > 10;





