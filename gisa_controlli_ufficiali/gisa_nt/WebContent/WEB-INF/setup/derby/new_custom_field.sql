-- ----------------------------------------------------------------------------
--  Apache Derby Table Creation
--
--  @author     Andrei I. Holub
--  @created    August 31, 2006
--  @version    $Id:$
-- ----------------------------------------------------------------------------

-- The link between the field category & modules
CREATE TABLE module_field_categorylink (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
  module_id INTEGER NOT NULL REFERENCES permission_category(category_id),
  category_id INT UNIQUE NOT NULL,
  "level" INTEGER DEFAULT 0,
  description CLOB,
  entered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Each module can have multiple categories or folders of custom data
CREATE TABLE custom_field_category (
  module_id INTEGER NOT NULL REFERENCES module_field_categorylink(category_id),
  category_id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL,
  "level" INTEGER DEFAULT 0,
  description CLOB,
  start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP,
  default_item CHAR(1) DEFAULT '0',
  entered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enabled CHAR(1) DEFAULT '1',
  multiple_records CHAR(1) DEFAULT '0',
  read_only CHAR(1) DEFAULT '0',
  modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX custom_field_cat_idx ON custom_field_category (module_id);

-- Each category can have multiple groups of fields
CREATE TABLE custom_field_group (
  category_id INTEGER NOT NULL REFERENCES custom_field_category(category_id),
  group_id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
  group_name VARCHAR(255) NOT NULL,
  "level" INTEGER DEFAULT 0,
  description CLOB,
  start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP,
  entered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enabled CHAR(1) DEFAULT '1',
  modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX custom_field_grp_idx ON custom_field_group (category_id);


-- Each folder has defined custom fields
CREATE TABLE custom_field_info (
  group_id INTEGER NOT NULL REFERENCES custom_field_group(group_id),
  field_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  field_name VARCHAR(255) NOT NULL,
  "level" INTEGER DEFAULT 0,
  field_type INTEGER NOT NULL,
  validation_type INTEGER DEFAULT 0,
  required CHAR(1) DEFAULT '0',
  parameters CLOB,
  start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP DEFAULT NULL,
  entered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  enabled CHAR(1) DEFAULT '1',
  additional_text VARCHAR(255),
  modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX custom_field_inf_idx ON custom_field_info (group_id);

-- List of values for type lookup table
CREATE TABLE custom_field_lookup (
  field_id INTEGER NOT NULL REFERENCES custom_field_info(field_id),
  code INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  default_item CHAR(1) DEFAULT '0',
  "level" INTEGER DEFAULT 0,
  start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP,
  entered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  enabled CHAR(1) DEFAULT '1',
  modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- The saved records in a folder associated with each category_id
CREATE TABLE custom_field_record (
  link_module_id INTEGER NOT NULL,
  link_item_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL REFERENCES custom_field_category(category_id),
  record_id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
  entered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL REFERENCES "access"(user_id),
  modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL REFERENCES "access"(user_id),
  enabled CHAR(1) DEFAULT '1'
);

CREATE INDEX custom_field_rec_idx ON custom_field_record (link_module_id, link_item_id, category_id);

-- The saved custom field data related to a record_id (link_id)
CREATE TABLE custom_field_data (
  record_id INTEGER NOT NULL REFERENCES custom_field_record(record_id),
  field_id INTEGER NOT NULL REFERENCES custom_field_info(field_id),
  selected_item_id INTEGER DEFAULT 0,
  entered_value CLOB,
  entered_number INTEGER,
  entered_float FLOAT,
  entered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  data_id INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY  
);

CREATE INDEX custom_field_dat_idx ON custom_field_data (record_id, field_id);

