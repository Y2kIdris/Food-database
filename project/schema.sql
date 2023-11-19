-- statements that compose it
-- Table of users who order food
CREATE TABLE "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL UNIQUE CHECK(LENGTH("password") >= 8),
    "discount_status" TEXT NOT NULL CHECK("discount_status" IN ('qualified', 'not qualified')),
    "email_address" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Table for food business/providers are reponsibe for creating the food
CREATE TABLE "food_businesses" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "type" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Table for food products that can be ordered
CREATE TABLE "food_products" (
    "id" INTEGER,
    "business_id" INTEGER,
    "product_name"  TEXT NOT NULL UNIQUE,
    "type" TEXT NOT NULL CHECK("type" IN ('fast-food', 'food', 'fruits/vegetables', 'beverages')),
    "price" NUMERIC NOT NULL,
    "extras" TEXT,
    "preparation_duration" TEXT,
    "applicable_discount" REAL NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("business_id") REFERENCES "food_businesses"("id")
);

-- Table that takes account of orders and the duration of preparing the orders
CREATE TABLE "orders" (
    "id" INTEGER,
    "user_id" INTEGER,
    "product_id" INTEGER,
    "product_id2" INTEGER,
    "quantity" INTEGER NOT NULL,
    "quantity2" INTEGER NOT NULL,
    "amount_charged" NUMERIC NOT NULL,
    "description" TEXT NOT NULL,
    "status" TEXT NOT NULL CHECK("status" IN ('completed', 'cancelled')),
    "start_time" DATETIME NOT NULL,
    "end_time" DATETIME NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("product_id") REFERENCES "food_products"("id"),
    FOREIGN KEY("product_id2") REFERENCES "food_products"("id")
);

-- Table for drivers name and identity number
CREATE TABLE "drivers" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Table for addresses where orders are to be delivered to
CREATE TABLE "addresses" (
    "id" INTEGER,
    "user_id" INTEGER,
    "address" TEXT NOT NULL,
    "postal-code" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id") ON DELETE CASCADE
);

-- Table that handles all aspect of deliveries
CREATE TABLE "deliveries" (
    "user_id" INTEGER,
    "address_id" INTEGER,
    "order_id" INTEGER,
    "driver_id" INTEGER,
    "estimated_time" TEXT NOT NULL,
    "date" DATE NOT NULL,
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("address_id") REFERENCES "addresses"("id") ON DELETE CASCADE,
    FOREIGN KEY("order_id") REFERENCES "orders"("id"),
    FOREIGN KEY("driver_id") REFERENCES "drivers"("id")
);

-- Table concerning reviews of products and drivers
CREATE TABLE "reviews" (
    "id" INTEGER,
    "product_id" INTEGER,
    "driver_id" INTEGER,
    "product_review" TEXT NOT NULL,
    "driver_review" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("product_id") REFERENCES "food_products"("id"),
    FOREIGN KEY("driver_id") REFERENCES "drivers"("id")
);

-- This view displays what address is connected to what user
CREATE VIEW "user_address" AS
SELECT "first_name", "last_name", "address"
FROM "users"
JOIN "addresses" ON "addresses"."user_id" = "users"."id";

-- This is view displays all users who qualified for discounts based on ordering more than 3 times
CREATE VIEW "qualified_by_frequency" AS
SELECT COUNT("user_id")
FROM "orders"
GROUP BY "user_id"
HAVING COUNT("user_id") > 3;

-- This is a view that displays users that have spent more than $500 on their orders
CREATE VIEW "valuable_user" AS
SELECT "first_name", "last_name", SUM("amount_charged") AS "value"
FROM "users"
JOIN "orders" ON "orders"."user_id" = "users"."id"
GROUP BY "user_id"
HAVING "value" > 1000
ORDER BY "value" DESC;

-- This views is used to ascertain the time it takes to prepare an order
CREATE VIEW "preparation_duration" AS
SELECT "product_name", strftime('%R', "start_time") - strftime('%R', "end_time") AS "preparation_duration"
FROM "food_product"
JOIN "orders" ON "orders"."product_id" = "food_products"."id"
ORDER BY "preparation_duration";

--Sometimes users complain about not receiving their order, these indexes are used when running investigations on
--why the order didn't the get to the user
CREATE INDEX "examine_delivery" ON "deliveries" ("order_id", "address_id");
CREATE INDEX "time_search" ON "orders" ("start_time", "end_time");
CREATE INDEX "user_search" ON "users" ("first_name", "last_name");
CREATE INDEX "postal_search" ON "addresses" ("address", "postal-code");

