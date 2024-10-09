-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Ongoing investigations
SELECT * FROM "investigations"
WHERE "ongoing" = 1;

-- Contact info of witnesses related to a particular investigation (investigation id #1 in this example)
SELECT
    "first_name",
    "last_name",
    "contact_info"
FROM "witnesses"
JOIN "investigation_witnesses" ON "witnesses"."id" = "investigation_witnesses"."witness_id"
WHERE "investigation_witnesses"."investigation_id" = 1;

-- Suspect information for a particular investigation (investigation id #1 in this example)
SELECT
    "first_name",
    "last_name",
    "contact_info",
    "date_of_birth",
    "gender",
    "criminal_record"
FROM "suspects"
JOIN "investigation_suspects" ON "suspects"."id" = "investigation_suspects"."suspect_id"
WHERE "investigation_suspects"."investigation_id" = 1;

-- Detective on a particular investigation (investigation id #1 in this example)
SELECT
    "first_name",
    "last_name",
    "badge_number",
    "rank"
FROM "detectives"
JOIN "investigation_detectives" ON "detectives"."id" = "investigation_detectives"."detective_id"
WHERE "investigation_detectives"."investigation_id" = 1;

-- Insert a new suspect into the database
INSERT INTO "suspects" ("id", "first_name", "last_name", "date_of_birth", "gender", "criminal_record")
VALUES (4, 'Dominic', 'Santini', '1989-01-25', 'Male', 'Stopped vehicle in front of train tracks');

-- Insert row into the "investigation_suspects" table
INSERT INTO "investigation_suspects" ("investigation_id", "suspect_id", "role")
VALUES
(1, 4, 'Person of interest');

-- Update row for the "investigation_suspects" table
UPDATE "investigation_suspects"
SET "role" = 'Primary Suspect'
WHERE "suspect_id" = 4;

-- Delete row for the "investigation_suspects" table
DELETE FROM "investigation_suspects"
WHERE "suspect_id" = 4;

-- Use "arrests_list" view to find an arrest associated with particular investigation (investigation id #1 in this example)
SELECT * FROM "arrests_list" WHERE "Investigation ID" = 1;
