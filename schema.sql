-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Represents ongoing and past investigations
CREATE TABLE IF NOT EXISTS "investigations" (
    "id" INTEGER,
    "crime_type" TEXT NOT NULL CHECK (crime_type IN ('Theft', 'Assault', 'Burglary', 'Fraud', 'Vandalism', 'Drug Offenses', 'Homicide', 'Other')), -- Only allow predefined crime types
    "crime_description" TEXT,
    "crime_date" TIMESTAMP NOT NULL,
    "crime_location" TEXT,
    "ongoing" INTEGER DEFAULT 1, -- 0 for false, 1 for true
    PRIMARY KEY("id")
);

-- Represents suspects of crimes
CREATE TABLE IF NOT EXISTS "suspects" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "date_of_birth" DATE,
    "gender" TEXT CHECK(gender IN ('Male', 'Female', 'Other')), -- Use CHECK for gender values
    "criminal_record" TEXT,
    PRIMARY KEY("id")
);

-- Represents detectives for crimes
CREATE TABLE IF NOT EXISTS "detectives" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "badge_number" TEXT UNIQUE NOT NULL,
    "rank" TEXT,
    PRIMARY KEY("id")
);

-- Represents witnesses of crimes
CREATE TABLE IF NOT EXISTS "witnesses" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "contact_info" TEXT,
    PRIMARY KEY("id")
);

-- Many-to-Many relationship between "investigations" and "suspects"
CREATE TABLE IF NOT EXISTS "investigation_suspects" (
    "investigation_id" INTEGER,
    "suspect_id" INTEGER,
    "role" TEXT,
    PRIMARY KEY("investigation_id", "suspect_id"), -- composite primary key
    FOREIGN KEY("investigation_id") REFERENCES "investigations"("id"),
    FOREIGN KEY("suspect_id") REFERENCES "suspects"("id")
);

-- Many-to-Many relationship between "investigations" and "detectives"
CREATE TABLE IF NOT EXISTS "investigation_detectives" (
    "investigation_id" INTEGER,
    "detective_id" INTEGER,
    "assignment_role" TEXT,
    PRIMARY KEY("investigation_id", "detective_id"), -- composite primary key
    FOREIGN KEY("investigation_id") REFERENCES "investigations"("id"),
    FOREIGN KEY("detective_id") REFERENCES "detectives"("id")
);

-- Many-to-Many relationship between "investigations" and "witnesses"
CREATE TABLE IF NOT EXISTS "investigation_witnesses" (
    "investigation_id" INTEGER,
    "witness_id" INTEGER,
    "statement" TEXT,
    PRIMARY KEY("investigation_id", "witness_id"), -- composite primary key
    FOREIGN KEY("investigation_id") REFERENCES "investigations"("id"),
    FOREIGN KEY("witness_id") REFERENCES "witnesses"("id")
);

-- Represents the arrests that correspond to crime, suspects, detectives
CREATE TABLE IF NOT EXISTS "arrests" (
  "arrest_id" INTEGER PRIMARY KEY,
  "investigation_id" INTEGER,
  "suspect_id" INTEGER,
  "detective_id" INTEGER,
  "arrest_date" TIMESTAMP,
  "charges" TEXT,
  FOREIGN KEY ("investigation_id") REFERENCES "investigations"("id"),
  FOREIGN KEY ("suspect_id") REFERENCES "suspects"("id"),
  FOREIGN KEY ("detective_id") REFERENCES "detectives"("id")
);

-- View that takes arrests joined with corresponding investigation, suspect, detective info on a particular investigation
CREATE VIEW IF NOT EXISTS "arrests_list" AS
SELECT
    "investigations"."id" AS "Investigation ID",
    "investigations"."crime_type" AS "Crime Type",
    "investigations"."crime_description" AS "Crime Description",
    "suspects"."last_name" AS "Suspect Arrests",
    "detectives"."last_name" AS "Detective",
    "arrests"."arrest_date" AS "Arrest Date",
    "arrests"."charges" AS "Charges"
FROM "arrests"
JOIN "investigations" ON "investigations"."id" = "arrests"."investigation_id"
JOIN "suspects" ON "suspects"."id" = "arrests"."suspect_id"
JOIN "detectives" ON "detectives"."id" = "arrests"."detective_id";

-- Indexes
-- Index on "crime_type" for faster queries by crime type
CREATE INDEX idx_investigations_crime_type ON investigations("crime_type");

-- Index on "crime_date" for quicker range searches on crime date
CREATE INDEX idx_investigations_crime_date ON investigations("crime_date");

-- Index on "last_name" for faster searches by suspect's last name
CREATE INDEX idx_suspects_last_name ON suspects("last_name");

-- Index on "date_of_birth" for efficient filtering by age or birthdate
CREATE INDEX idx_suspects_date_of_birth ON suspects("date_of_birth");

-- Index on "badge_number" for quick access by detective's badge number (although it's already UNIQUE, this ensures quick lookups)
CREATE INDEX idx_detectives_badge_number ON detectives("badge_number");

-- Index on "last_name" for detectives to speed up queries by last name
CREATE INDEX idx_detectives_last_name ON detectives("last_name");

-- Index on "contact_info" in witnesses for more efficient searches by witness contact information
CREATE INDEX idx_witnesses_contact_info ON witnesses("contact_info");

-- Index on "suspect_id" in "arrests" for faster searches on suspects involved in arrests
CREATE INDEX idx_arrests_suspect_id ON arrests("suspect_id");

-- Index on "investigation_id" for fast lookup of investigations in related tables
CREATE INDEX idx_arrests_investigation_id ON arrests("investigation_id");
CREATE INDEX idx_investigation_suspects_investigation_id ON investigation_suspects("investigation_id");
CREATE INDEX idx_investigation_detectives_investigation_id ON investigation_detectives("investigation_id");
CREATE INDEX idx_investigation_witnesses_investigation_id ON investigation_witnesses("investigation_id");

-- Index on arrest_id (if queries are often filtering by arrest_id)
CREATE INDEX idx_arrests_arrest_id ON arrests("arrest_id");


