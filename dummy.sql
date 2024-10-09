-- Dummy dataset to be used for mock queries
-- Insert dummy data into the "investigations" table
INSERT INTO "investigations" ("id", "crime_type", "crime_description", "crime_date", "crime_location", "ongoing")
VALUES
(1, 'Theft', 'Stolen electronics from a store', '2023-07-15', '123 Main St', 0),
(2, 'Assault', 'Physical altercation in a bar', '2023-08-21', '456 Elm St', 1),
(3, 'Burglary', 'Break-in at a residential house', '2023-09-02', '789 Oak St', 1);

-- Insert dummy data into the "suspects" table
INSERT INTO "suspects" ("id", "first_name", "last_name", "date_of_birth", "gender", "criminal_record")
VALUES
(1, 'John', 'Doe', '1990-02-15', 'Male', 'Previous theft charges'),
(2, 'Jane', 'Smith', '1985-06-22', 'Female', 'Assault and battery'),
(3, 'Mike', 'Johnson', '1993-11-10', 'Male', NULL);

-- Insert dummy data into the "detectives" table
INSERT INTO "detectives" ("id", "first_name", "last_name", "badge_number", "rank")
VALUES
(1, 'Alice', 'Brown', 'D12345', 'Sergeant'),
(2, 'Bob', 'Williams', 'D54321', 'Detective'),
(3, 'Charlie', 'Miller', 'D67890', 'Lieutenant');

-- Insert dummy data into the "witnesses" table
INSERT INTO "witnesses" ("id", "first_name", "last_name", "contact_info")
VALUES
(1, 'Emily', 'Davis', 'emily@example.com'),
(2, 'Michael', 'Wilson', 'michael@example.com'),
(3, 'Sara', 'Lee', 'sara@example.com');

-- Insert dummy data into the "investigation_suspects" table
INSERT INTO "investigation_suspects" ("investigation_id", "suspect_id", "role")
VALUES
(1, 1, 'Primary suspect'),
(2, 2, 'Primary suspect'),
(3, 3, 'Person of interest');

-- Insert dummy data into the "investigation_detectives" table
INSERT INTO "investigation_detectives" ("investigation_id", "detective_id", "assignment_role")
VALUES
(1, 1, 'Lead investigator'),
(2, 2, 'Investigator'),
(3, 3, 'Investigator');

-- Insert dummy data into the "investigation_witnesses" table
INSERT INTO "investigation_witnesses" ("investigation_id", "witness_id", "statement")
VALUES
(1, 1, 'Saw the suspect fleeing the scene'),
(2, 2, 'Heard shouting before the incident'),
(3, 3, 'Witnessed the break-in from across the street');

-- Insert dummy data into the "arrests" table
INSERT INTO "arrests" ("arrest_id", "investigation_id", "suspect_id", "detective_id", "arrest_date", "charges")
VALUES
(1, 1, 1, 1, '2023-07-16', 'Theft'),
(2, 2, 2, 2, '2023-08-22', 'Assault'),
(3, 3, 3, 3, '2023-09-05', 'Burglary');

