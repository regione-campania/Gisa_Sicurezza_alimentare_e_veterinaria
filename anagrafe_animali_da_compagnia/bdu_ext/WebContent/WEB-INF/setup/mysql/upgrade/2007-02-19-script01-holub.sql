ALTER TABLE ticket_category ADD COLUMN entered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
UPDATE ticket_category SET entered = CURRENT_TIMESTAMP;

ALTER TABLE ticket_category ADD COLUMN modified TIMESTAMP NULL;

ALTER TABLE ticket_category_draft ADD COLUMN entered TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP;
UPDATE ticket_category_draft SET entered = CURRENT_TIMESTAMP;

ALTER TABLE ticket_category_draft ADD COLUMN modified TIMESTAMP NULL;