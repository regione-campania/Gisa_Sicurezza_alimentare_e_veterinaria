-- Table ORDER_ADDRESS

CREATE TABLE order_address
(
  address_id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  contact_id INTEGER,
  address_type INTEGER,
  addrline1 varchar(80),
  addrline2 varchar(80),
  addrline3 varchar(80),
  addrline4 varchar(80),
  city varchar(80),
  state varchar(80),
  country varchar(80),
  postalcode varchar(12),
  entered timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INTEGER NOT NULL,
  modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INTEGER NOT NULL,
  primary_address CHAR(1) NOT NULL DEFAULT '0',
  CONSTRAINT order_address_pkey PRIMARY KEY (address_id),
  CONSTRAINT order_address_address_type_fkey FOREIGN KEY (address_type)
      REFERENCES lookup_contactaddress_types (code)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT order_address_contact_id_fkey FOREIGN KEY (contact_id)
      REFERENCES contact (contact_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT order_address_enteredby_fkey FOREIGN KEY (enteredby)
      REFERENCES "access" (user_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT order_address_modifiedby_fkey FOREIGN KEY (modifiedby)
      REFERENCES "access" (user_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX order_address_contact_id_idx
  ON order_address
  (contact_id);

CREATE INDEX order_address_postalcode_idx
  ON order_address
  (postalcode);

CREATE INDEX order_address_prim_idx
  ON order_address
  (primary_address);

-- Index: contact_city_idx

CREATE INDEX order_city_idx
  ON order_address
  (city);

-- Table ORDER_ENTRY

ALTER TABLE ORDER_ENTRY 
  ADD COLUMN approx_ship_date timestamp;

ALTER TABLE ORDER_ENTRY 
  ADD COLUMN approx_delivery_date timestamp;

-- Table CUSTOMER_PRODUCT

ALTER TABLE customer_product
 ADD COLUMN contact_id INTEGER;

-- Table CUSTOMER_PRODUCT_HISTORY

ALTER TABLE customer_product_history
 ADD COLUMN contact_id INTEGER ;
 
-- Table CREDIT_CARD

CREATE TABLE credit_card
(
  creditcard_id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  card_type INTEGER,
  card_number varchar(300),
  card_security_code varchar(300),
  expiration_month INTEGER,
  expiration_year INTEGER,
  name_on_card varchar(300),
  company_name_on_card varchar(300),
  entered timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INTEGER NOT NULL,
  modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INTEGER NOT NULL,
  CONSTRAINT creditcard_pkey PRIMARY KEY (creditcard_id),
  CONSTRAINT creditcard_card_type_fkey FOREIGN KEY (card_type)
      REFERENCES lookup_creditcard_types (code)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT creditcard_enteredby_fkey FOREIGN KEY (enteredby)
      REFERENCES "access" (user_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT creditcard_modifiedby_fkey FOREIGN KEY (modifiedby)
      REFERENCES "access" (user_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Table LOOKUP_PAYMENT_GATEWAY

-- DROP TABLE lookup_call_priority;

CREATE TABLE lookup_payment_gateway
(
  code INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  description varchar(50) NOT NULL,
  default_item CHAR(1) DEFAULT '0',
  "level" INTEGER DEFAULT 0,
  enabled CHAR(1) DEFAULT '1',
  constant_id INTEGER,
  CONSTRAINT lookup_payment_gateway_pkey PRIMARY KEY (code)
);

INSERT INTO lookup_lists_lookup 
        (module_id, lookup_id, class_name, table_name, level, description, category_id)
        VALUES (22, 1108061056, 'lookupList', 'lookup_payment_gateway', 10, 'Payment gateways', 420041018); 

INSERT INTO lookup_payment_gateway
        ( description, level, enabled, constant_id) 
        VALUES ('Authorize.net',10, '1', 8110621);
INSERT INTO lookup_payment_gateway
        ( description, level, enabled, constant_id) 
        VALUES ('PPIPaymover',10, '1', 8110622);
        
-- Table MERCHANT_PAYMENT_GATEWAY

CREATE TABLE merchant_payment_gateway
(
  merchant_payment_gateway_id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  gateway_id INTEGER,
  merchant_id varchar(300),
  merchant_code varchar(1024),
  entered timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INTEGER NOT NULL,
  modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INTEGER NOT NULL,
  CONSTRAINT merchant_payment_gateway_id_pkey PRIMARY KEY (merchant_payment_gateway_id),
  CONSTRAINT merchant_payment_gateway_gateway_id_fkey FOREIGN KEY (gateway_id)
      REFERENCES lookup_payment_gateway (code)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);