--- Term Project 1 ---
--- Deep Parekh ---
--- c0812123 ---
--- Juicers ---
--- Winter 2021, Term 1 ---
--- Professor Name: James Cooper ---

DROP TABLE tp_warehouse; 
DROP TABLE tp_brand;   
DROP TABLE tp_model;   
DROP TABLE tp_product;  
DROP TABLE tp_product_warehouse; 
DROP TABLE tp_tax_history;       
DROP TABLE tp_associate;   
DROP TABLE tp_pincode;
DROP TABLE tp_address;
DROP TABLE tp_customer;
DROP TABLE tp_order;   
DROP TABLE tp_product_order;   

--- Create Statements ---

CREATE TABLE tp_warehouse(
warehouse_id      decimal (2,0)     NOT NULL,
location_name     varchar (40)      NOT NULL
);

CREATE TABLE tp_brand(
brand_id          decimal (3,0)     NOT NULL,
brand_name        varchar (30)      NOT NULL
);

CREATE TABLE tp_model(
model_id          decimal (5,0)     NOT NULL,
model_name        varchar (30)      NOT NULL,
speed_options     integer,
motor_power       varchar(10),
body_material     varchar (40),
decibel_level     varchar(20),
color             varchar(15),
warranty          varchar(15)       NOT NULL 
);

CREATE TABLE tp_product(
product_id          varchar(20)     NOT NULL,
product_dimensions  varchar(50)     NOT NULL,
weight              varchar(20)     NOT NULL,
pulp_container      varchar(10)     NOT NULL,
collector_capacity  varchar (10)    NOT NULL,
price               decimal (8,2),
brand_id            decimal (3,0)   NOT NULL,
model_id            decimal (5,0)   NOT NULL 
);

CREATE TABLE tp_product_warehouse(
warehouse_id        decimal (2,0)   NOT NULL,
product_id          varchar (20)    NOT NULL,
stock               integer         NOT NULL
);

CREATE TABLE tp_tax_history(
tax_id              decimal (4,0)   NOT NULL,
start_date          date            NOT NULL,
end_date            date
);

CREATE TABLE tp_associate(
associate_id        decimal (3,0)   NOT NULL,
associate_name      varchar (50)    NOT NULL 
);

CREATE TABLE tp_pincode(
pincode             varchar (10)    NOT NULL,
locality            varchar (30)
);

CREATE TABLE tp_address(
address_id          decimal (5,2)   NOT NULL,
house_name          varchar (20),
street_name         varchar (30)    NOT NULL,
city                varchar (30)    NOT NULL,
province            varchar (20),
pincode             varchar (10)    NOT NULL
);

CREATE TABLE tp_customer(
customer_id         decimal (5,0)   NOT NULL      GENERATED ALWAYS AS IDENTITY  (START WITH 1000 INCREMENT BY 5),
customer_name       varchar (50)    NOT NULL,
address_id          decimal (5,2)   NOT NULL
);

CREATE TABLE tp_order(
order_id            varchar (10)    NOT NULL,
order_date          date            NOT NULL      DEFAULT current_date,
customer_id         decimal (5,0)   NOT NULL,
tax_id              decimal (4,0)   NOT NULL,
associate_id        decimal (3,0)   NOT NULL,
total_amount        decimal (10,2)  NOT NULL
);

CREATE TABLE tp_product_order(
order_id            varchar (10)    NOT NULL,
product_id          varchar (20)    NOT NULL,
quantity            integer         NOT NULL      DEFAULT 1,
price               integer,
description         varchar (60)    
);

---- Primary Keys ---

ALTER TABLE tp_warehouse
ADD CONSTRAINT tp_warehouse_pk
PRIMARY KEY (warehouse_id);

ALTER TABLE tp_brand
ADD CONSTRAINT tp_brand_pk
PRIMARY KEY (brand_id);

ALTER TABLE tp_model
ADD CONSTRAINT tp_model_pk
PRIMARY KEY (model_id);

ALTER TABLE tp_product
ADD CONSTRAINT tp_product_pk
PRIMARY KEY (product_id);

ALTER TABLE tp_product_warehouse
ADD CONSTRAINT tp_product_warehouse_pk
PRIMARY KEY (warehouse_id, product_id);

  ALTER TABLE TP_PRODUCT_WAREHOUSE 
  ADD CONSTRAINT tp_product_warehouse_warehouse_id_fk
  FOREIGN KEY (warehouse_id)
  REFERENCES tp_warehouse(warehouse_id);


  ALTER TABLE tp_product_warehouse
  ADD CONSTRAINT tp_product_warehouse_product_id_fk
  FOREIGN KEY (product_id)
  REFERENCES tp_product(product_id);

ALTER TABLE tp_tax_history
ADD CONSTRAINT tp_tax_history_pk
PRIMARY KEY (tax_id);

ALTER TABLE tp_associate
ADD CONSTRAINT tp_associate_pk
PRIMARY KEY (associate_id);

ALTER TABLE tp_pincode
ADD CONSTRAINT tp_pincode_pk
PRIMARY KEY (pincode);

ALTER TABLE tp_address
ADD CONSTRAINT tp_address_pk
PRIMARY KEY (address_id);

ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_pk
PRIMARY KEY (customer_id);

ALTER TABLE tp_order
ADD CONSTRAINT tp_order_pk
PRIMARY KEY (order_id);

ALTER TABLE tp_product_order
ADD CONSTRAINT tp_product_order_pk
PRIMARY KEY (order_id, product_id);

  ALTER TABLE tp_product_order
  ADD CONSTRAINT tp_product_order_order_id_fk
  FOREIGN KEY (order_id)
  REFERENCES tp_order(order_id);

  ALTER TABLE tp_product_order
  ADD CONSTRAINT tp_product_order_product_id_fk
  FOREIGN KEY (product_id)
  REFERENCES tp_product(product_id);

---- Unique Keys ----

ALTER TABLE tp_brand
ADD CONSTRAINT tp_brand_brand_name_uk
UNIQUE (brand_name);

ALTER TABLE tp_model
ADD CONSTRAINT tp_model_model_name_uk
UNIQUE (model_name);

---- Foreign Keys ---

ALTER TABLE TP_PRODUCT 
ADD CONSTRAINT tp_product_brand_id_fk
FOREIGN KEY (brand_id)
REFERENCES tp_brand(brand_id);

ALTER TABLE TP_PRODUCT 
ADD CONSTRAINT tp_product_model_id_fk
FOREIGN KEY (model_id)
REFERENCES tp_model(model_id);

ALTER TABLE tp_address
ADD CONSTRAINT tp_address_pincode_fk
FOREIGN KEY (pincode)
REFERENCES tp_pincode(pincode);

ALTER TABLE TP_CUSTOMER 
ADD CONSTRAINT tp_customer_address_id_fk
FOREIGN KEY (address_id)
REFERENCES tp_address(address_id);

ALTER TABLE tp_order
ADD CONSTRAINT tp_order_customer_id_fk
FOREIGN KEY (customer_id)
REFERENCES tp_customer(customer_id);

ALTER TABLE tp_order
ADD CONSTRAINT tp_order_tax_id_fk
FOREIGN KEY (tax_id)
REFERENCES tp_tax_history(tax_id);

ALTER TABLE tp_order
ADD CONSTRAINT tp_order_associate_id_fk
FOREIGN KEY (associate_id)
REFERENCES tp_associate(associate_id);

---- Check Constraint ----

ALTER TABLE TP_MODEL 
  ADD CONSTRAINT tp_model_speed_options_ck
  CHECK (speed_options BETWEEN 1 AND 5);

ALTER TABLE TP_PRODUCT_WAREHOUSE 
  ADD CONSTRAINT tp_product_warehouse_stock_ck
  CHECK (stock >= 0);

ALTER TABLE TP_PRODUCT_ORDER 
  ADD CONSTRAINT tp_product_order_quantity_ck
  CHECK (quantity >= 1);
  
ALTER TABLE TP_BRAND 
  ADD CONSTRAINT tp_brand_brand_name_ck
  CHECK (brand_name IN ('Kuvings', 'Bajaj', 'Kent', 'Boss', 'Rico'));

ALTER TABLE TP_ORDER 
  ADD CONSTRAINT tp_order_total_amount_ck
  CHECK (total_amount >= 100);

----- Populate Tables -----

INSERT INTO TP_PINCODE VALUES
('48288', 'Michigan'),
('M5V2K1', 'Ontario'),
('60099', NULL),
('NJ6785', 'New Jersey'),
('HT4963', 'Texas');

INSERT INTO TP_ADDRESS  VALUES
(233.21, NULL, '1275 Main St', 'Detroit', 'MI', '48288'),
(365.33, NULL, '532 Jackson', 'Toronto', 'ON', 'M5V2K1'),
(489.25, 'Tom', '1626 Taylor', 'Chicago', 'IL', '60099'),
(784.65, 'Jesus', '15 Rio', 'Edison', NULL, 'NJ6785'),
(358.15, NULL, 'S19 Death Valley', 'Houston', 'Texas', 'HT4963');

--- 5 Customers ----
INSERT INTO TP_CUSTOMER VALUES
(DEFAULT, 'Macon Stinson', 233.21),
(DEFAULT, 'John Stevens', 365.33),
(DEFAULT, 'Smith Dave', 489.25),
(DEFAULT, 'Adam Stark', 784.65),
(DEFAULT, 'Cameron Finch', 358.15);

--- 3 associates ---
INSERT INTO TP_ASSOCIATE  VALUES
(267, 'Joshua Bing'),
(357, 'Swarley Mosby'),
(254, 'Cersei Grejoy');

INSERT INTO TP_BRAND VALUES
(111, 'Kuvings'),
(113, 'Bajaj'),
(115, 'Kent'),
(117, 'Boss'),
(119,'Rico');

INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES (32156, 'Cold Press', 2, '800W', 'SS Chrome Finish', '80-90 dB', 'Silver', '1 year');

INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES(32159, 'Manual', NULL, '300W', 'Plastic', NULL, 'Orange', '6 months');

INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES(32162, 'Centrifugal', 3, '1200W', 'Stainless Steel', NULL, 'Metallic bronze', '2 years');

INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES(32165, 'Automatic', NULL, NULL, 'Fiber body', 'less than 70dB', 'Mustard', '1 year');

INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES(32168, 'Slow juicer', 1, NULL, NULL, NULL, NULL, '6 months');

--- 10 Products ---
INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('EJ10789H', '27.2 x 22.9 x 33.8 cm', '3.88 kg', '3 liters', '2 liters', 2500.00, 111, 32156);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('ZE266C', '25 x 20 x 30 cm', '2.8 kg', '2 liters', '1.5 liters', 1200.00, 113, 32159);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('CO389D', '48 x 45 x 57 cm', '10 kg', '12 liters', '10 liters', 15000.00, 115, 32162);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('GB1593V', '20 x 18 x 25 cm', '2.5 kg', '3 liters', '1.5 liters', 1800.00, 117, 32165);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES('JY369S', '15 x 12 x 18 cm', '1.5 kg', '1 liter', '0.5 liter', 700.00, 119, 32168);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('EJ10788B', '26.2 x 22.9 x 31.8 cm', '3.5 kg', '2 liters', '1 liters', 1500.00, 111, 32168);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('ZE244B', '28 x 26.2 x 30 cm', '3.2 kg', '2.5 liters', '2 liters', 2000.00, 113, 32165);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('CO341F', '24 x 22 x 30 cm', '6 kg', '7 liters', '6 liters', 8000.00, 117, 32162);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('GB15468M', '27 x 25.8 x 32 cm', '3.5 kg', '5 liters', '4.5 liters', 4500.00, 115, 32159);

INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES('JY323L', '18 x 15 x 22 cm', '2.8 kg', '1.5 liter', '1.2 liter', 3200.00, 119, 32156);

INSERT INTO TP_WAREHOUSE 
VALUES (10, 'Chicago');

INSERT INTO TP_WAREHOUSE 
VALUES (20, 'Detroit');

INSERT INTO TP_WAREHOUSE 
VALUES (30, 'Toronto');

INSERT INTO TP_PRODUCT_WAREHOUSE  VALUES 
(10, 'EJ10789H', 50),
(20, 'EJ10789H', 20),
(30, 'EJ10789H', 5),
(10, 'ZE266C'  , 2),
(30, 'ZE266C'  , 60),
(10, 'CO389D'  , 200),
(20, 'GB1593V' , 150),
(30, 'GB1593V' , 45),
(20, 'JY369S'  , 380),
(10, 'EJ10788B', 30),
(20, 'EJ10788B', 15),
(30, 'EJ10788B', 48),
(10, 'ZE244B'  , 100),
(30, 'ZE244B'  , 89),
(30, 'CO341F'  , 410),
(20, 'GB15468M', 210),
(30, 'GB15468M', 157),
(10, 'JY323L'  , 79),
(20, 'JY323L'  , 318);

INSERT INTO TP_TAX_HISTORY VALUES
(5551, '2018-01-26', null),
(5552, '2008-03-15', null),
(5553, '1998-05-09', '2010-11-17');


CREATE OR replace SEQUENCE tp_order_id_seq 
START WITH 5001
INCREMENT BY 1;
NO CYCLE; 
NO CACHE;

--- 10 Orders with atleast two products on each order ---
---- Order 1 ----
INSERT INTO TP_ORDER (order_id, order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, '2019-01-25',      1010,   5551,         267, 3700 );

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity,   price,  description) VALUES
(previous value FOR tp_order_id_seq,    'EJ10789H', DEFAULT,    2500,    'cold press juicer'),
(previous value FOR tp_order_id_seq,    'ZE266C',   DEFAULT,    1200,    'manual juicer');

---- Order 2 ----
INSERT INTO TP_ORDER (order_id, order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, '2019-01-25',      1015,   5551,         267, 37200 );

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity,   price,  description) VALUES
(previous value FOR tp_order_id_seq,    'CO389D',    2,         15000,  'centrifugal juicer machine'),
(previous value FOR tp_order_id_seq,    'GB1593V',   4,         1800,   'automatic juicer machine');

---- Order 3 ----
INSERT INTO TP_ORDER (order_id, order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    default,      1020,   5552,         267, 10000);

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity, price,  description) VALUES
(previous value FOR tp_order_id_seq,    'JY369S',    10,      700,    'slow juicer'),
(previous value FOR tp_order_id_seq,    'EJ10788B',   2,      1500,   'Hydraulic press juicer');

---- Order 4 ----
INSERT INTO TP_ORDER (order_id,   order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, '2021-03-10',      1000,   5552,         267,    36000);

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity, price,  description) VALUES
(previous value FOR tp_order_id_seq,    'JY369S',    10,      700,    'slow juicer'),
(previous value FOR tp_order_id_seq,    'EJ10788B',   2,      1500,   'Hydraulic press juicer'),
(previous value FOR tp_order_id_seq,    'ZE244B',     5,      2000,   'Pulp Ejecting'),
(previous value FOR tp_order_id_seq,    'CO341F',     2,      8000,   'Masticating juicer');

---- Order 5 ----
INSERT INTO TP_ORDER (order_id,      order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    '2021-01-11',      1005,   5552,         357,   15700);

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity, price,  description) VALUES
(previous value FOR tp_order_id_seq,    'GB15468M', DEFAULT,  4500,   'triturating juicer'),
(previous value FOR tp_order_id_seq,    'JY323L',   DEFAULT,  3200,   'Wheatgrass juicer'),
(previous value FOR tp_order_id_seq,    'CO341F',   DEFAULT,  8000,   'Masticating juicer');

---- Order 6 ----
INSERT INTO TP_ORDER (order_id,       order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    '2020-09-26',      1010,   5551,         357,     23500);

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity, price,  description) VALUES
(previous value FOR tp_order_id_seq,    'GB15468M',   3,      4500,   'triturating juicer'),
(previous value FOR tp_order_id_seq,    'EJ10789H',   4,      2500,   'cold press juicer');

---- Order 7 ----
INSERT INTO TP_ORDER (order_id,   order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, '2021-03-10',      1015,   5552,         357,    49000);

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity, price,  description) VALUES
(previous value FOR tp_order_id_seq,    'EJ10789H',  10,      2500,   'cold press juicer'),
(previous value FOR tp_order_id_seq,    'EJ10788B',   2,      1500,   'Hydraulic press juicer'),
(previous value FOR tp_order_id_seq,    'ZE266C',     5,      1200,   'manual juicer'),
(previous value FOR tp_order_id_seq,    'CO389D',     1,      15000,  'centrifugal juicer machine'),
(previous value FOR tp_order_id_seq,    'GB1593V',    2,      1800,   'automatic juicer machine');

---- Order 8 ----
INSERT INTO TP_ORDER (order_id,   order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, '2019-01-25',      1020,   5552,         254,    8700);

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity, price,  description) VALUES
(previous value FOR tp_order_id_seq,    'JY369S',   DEFAULT,  700,    'slow juicer'),
(previous value FOR tp_order_id_seq,    'CO341F',   DEFAULT,  8000,   'Masticating juicer');

---- Order 9 ----
INSERT INTO TP_ORDER (order_id,  order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    DEFAULT,      1000,   5552,         254,    57200);

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity, price,  description) VALUES
(previous value FOR tp_order_id_seq,    'ZE244B',   10,       2000,   'Pulp Ejecting'),
(previous value FOR tp_order_id_seq,    'JY323L',    6,       3200,   'Wheatgrass juicer'),
(previous value FOR tp_order_id_seq,    'GB15468M',  4,       4500,   'triturating juicer');

---- Order 10 ----
INSERT INTO TP_ORDER (order_id,  order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    DEFAULT,      1005,   5553,         254,    100000);

INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity, price,  description) VALUES
(previous value FOR tp_order_id_seq,    'CO389D',    4,       15000,  'centrifugal juicer machine'),
(previous value FOR tp_order_id_seq,    'CO341F',    5,       8000,   'Masticating juicer');



--------------------------------UNIT TESTING DOCUMENTATION---------------------------------------------------

---- Test 1: Not Null ----
--- Description : Confirm null value is not accepted in warehouse_id column in tp_warehouse table.
--- Expected Results : Null insert fails with SQL 23502 null key error
--- Action
---- A. Valid Data is accepted --
 INSERT INTO TP_WAREHOUSE VALUES
 (40, 'Sarnia');
 
 --- B. Invalid Data is refused ---
 INSERT INTO TP_WAREHOUSE VALUES
 (NULL, 'Quebec');
 --- Error: SQL Error [23502]: [SQL0407] Null values not allowed in column or variable WAREHOUSE_ID. ---
 
 
 
 
 
 ---- Test 2 : Default ----
 --- Description : Confirm null value is not accepted in quantity column in tp_order where default is set to current date.
 --- Expected Results : Null Values will not be accepted in order_date column in tp_order
 --- Action
 --- A. Valid Data is accepted ---
INSERT INTO TP_ORDER (order_id, order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, DEFAULT,      1015,   5551,         267, 200 );

--- B. Invalid Data is refused ---
INSERT INTO TP_ORDER (order_id, order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, null,      1020,   5551,         267, 1000 );
---- SQL Error [23502]: [SQL0407] Null values not allowed in column or variable ORDER_DATE.





---- Test 3 : Primary Keys - 1 ---
---- Description : Confirm Primary Key constraint on warehouse_id column in tp_warehouse table.
--- Expected Results : Insert fails with SQL0803 duplicate key error.
--- Action
--- A. Valid Data is accepted ---
INSERT INTO TP_WAREHOUSE VALUES
 (50, 'Paris');
 
--- B. Invalid Data is refused ---
INSERT INTO TP_WAREHOUSE VALUES
 (30, 'London');
--- SQL Error [23505]: [SQL0803] Duplicate key value specified.

 
---- Test 3 : Primary Keys - 2 ---
---- Description : Confirm Primary Key constraint on tax_id column in tp_tax_history table.
--- Expected Results : Insert fails with SQL0803 duplicate key error.
--- Action
--- A. Valid Data is accepted ---
INSERT INTO TP_TAX_HISTORY VALUES
(5554, '2017-01-26', null);

--- B. Invalid Data is refused ---
INSERT INTO TP_TAX_HISTORY VALUES
(5551, '2015-08-23', null);
--- SQL Error [23505]: [SQL0803] Duplicate key value specified.






--- Test 4 : Unique Key ---
---- Description : Confirm unique key constraint on model_name column in tp_model table.
---- Expected Results : Insert fails with SQL0803 duplicate key error
--- Action
---- A. Valid Data is accepted ---
INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES (32175, 'Basic', 2, '800W', 'SS Chrome Finish', '80-90 dB', 'Silver', '1 year');

--- B. Invalid Data is refused ---
INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES (32176, 'Cold Press', 2, '800W', 'SS Chrome Finish', '80-90 dB', 'Silver', '1 year');
--- SQL Error [23505]: [SQL0803] Duplicate key value specified.





--- Test 5 : Foreign Keys - 1 ----
--- Description : Confirm foreign key constraint on pincode column in tp_address table.
--- Expected results : Insert fails with referential constraint
--- Action
---- A. Valid Data is accepted.
INSERT INTO TP_ADDRESS  VALUES
(234.78, NULL, '125 Lloyd St', 'Detroit', 'MI', '48288');

---- B. Invalid Data is refused.
INSERT INTO TP_ADDRESS  VALUES
(235.52, NULL, '27 George St', 'Quebec', 'ON', 'ON5623');
--- SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint TP_ADDRESS_PINCODE_FK in IBM7116.



--- Test 5 : Foreign Keys - 2 ----
--- Description : Confirm foreign key constraint on brand_id column in tp_product table.
--- Expected results : Insert fails with referential constraint
--- Action
---- A. Valid Data is accepted.
INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('Testpro', '27.2 x 22.9 x 33.8 cm', '3.88 kg', '3 liters', '2 liters', 2500.00, 111, 32156);

--- B. Invalid Data is refused.
INSERT INTO TP_PRODUCT 
(product_id, product_dimensions, weight, pulp_container, collector_capacity, price, brand_id, model_id )
VALUES ('Testpro2', '27.2 x 22.9 x 33.8 cm', '3.88 kg', '3 liters', '2 liters', 2500.00, 303, 32156);
--- SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint TP_PRODUCT_BRAND_ID_FK in IBM7116.



--- Test 5 : Foreign Keys - 3 ----
--- Description : Confirm foreign key constraint on associate_id column in tp_order table.
--- Expected results : Insert fails with referential constraint
--- Action
---- A. Valid Data is accepted.
INSERT INTO TP_ORDER (order_id, order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, '2019-01-25',      1010,   5551,         267, 960 );

--- B. Invalid is refused.
INSERT INTO TP_ORDER (order_id, order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq, '2019-01-25',      1010,   5551,         536, 780 );
--- SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint TP_ORDER_ASSOCIATE_ID_FK in IBM7116.



--- Test 5 : Foreign Keys - 4 ----
--- Description : Confirm foreign key constraint on product_id column in tp_product_warehouse table.
--- Expected results : Insert fails with referential constraint
--- Action
---- A. Valid Data is accepted.
INSERT INTO tp_product_warehouse VALUES 
(20, 'ZE266C'  , 60);

--- B. Invalid Data is refused.
INSERT INTO tp_product_warehouse VALUES
(30, 'testpro'  , 60);
--- SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint TP_PRODUCT_WAREHOUSE_PRODUCT_ID_FK in IBM7116.






--- Test 6 : Check Constraints - 1 ----
---- Description : Confirm check constraint for speed_options column in TP_MODEL table where speed_options are set between 1 and  5.
---- Expected Results : Insert fails with check constraint
--- Action
---- A. Valid Data is accepted
-- Lower Range = 1
INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES (45120, 'Test Model', 1, '800W', 'SS Chrome Finish', '80-90 dB', 'Silver', '1 year');
-- Upper Range = 5
INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES (45121, 'Test Model 2', 5, '800W', 'SS Chrome Finish', '80-90 dB', 'Silver', '1 year');


--- B. Invalid Data is Refused
-- Out of the range (= 10)
INSERT INTO TP_MODEL 
(model_id, model_name, speed_options, motor_power, body_material, decibel_level, color, warranty)
VALUES (45122, 'Test Model 3', 10, '800W', 'SS Chrome Finish', '80-90 dB', 'Silver', '1 year');
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.



--- Test 6 : Check Constraints - 2 ----
---- Description : Confirm check constraint for stock column in tp_product_warehouse table where stock  must be greater than or equal to zero.
---- Expected Results : Insert fails with check constraint.
--- Action
---- A. Valid Data is accepted
--- (stock >= 0)
INSERT INTO TP_PRODUCT_WAREHOUSE VALUES
(20, 'CO389D'  , 0);

---- B. Invalid Data is refused
INSERT INTO TP_PRODUCT_WAREHOUSE VALUES
(30, 'CO389D'  , -10);
---SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.


--- Test 6 : Check Constraints - 3 ----
---- Description : Confirm check constraint for quantity column in tp_product_order table where quantity must be greater than or equal to one.
---- Expected Results : Insert fails with check constraint.
--- Action
---- A. Valid Data is accepted
--- Minimum quantity = 1
INSERT INTO TP_ORDER (order_id,  order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    DEFAULT,      1005,   5551,         254,    1000);
INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity) VALUES
(previous value FOR tp_order_id_seq,    'GB15468M',   1);

--- B. Invalid Data is refused
INSERT INTO TP_ORDER (order_id,  order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    DEFAULT,      1020,   5551,         254,    1000);
INSERT INTO TP_PRODUCT_ORDER (order_id, product_id, quantity) VALUES
(previous value FOR tp_order_id_seq,    'GB15468M',   0);
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.



--- Test 6 : Check Constraints - 4 ----
---- Description : Confirm check constraint for quantity brand_name in tp_brand table where brand_name must be one of the following : 'Kuvings', 'Bajaj', 'Kent', 'Boss' or 'Rico'.
---- Expected Results : Insert fails with check constraint. 
--- Action
--- Invalid Data is Refused
INSERT INTO TP_BRAND VALUES
(181, 'Philips');
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.


--- Test 6 : Check Constraints - 5 ----
---- Description : Confirm check constraint for total_amount in tp_order table where total_amount must be greater than 100.
---- Expected Results : Insert fails with check constraint. 
--- Action
--- A. Valid Data is accepted
--- Minimum value for total_amount = 100
INSERT INTO TP_ORDER (order_id,  order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    DEFAULT,      1020,   5553,         254,    100);

--- B. Invalid Data is refused
--- Less than 100
INSERT INTO TP_ORDER (order_id,  order_date, customer_id, tax_id, associate_id, total_amount) VALUES 
(NEXT value FOR tp_order_id_seq,    DEFAULT,      1015,   5553,         254,    10);
 --- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
 