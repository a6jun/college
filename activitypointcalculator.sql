-- DDL Commands

CREATE TABLE _teacher(
        Teacher_id INT PRIMARY KEY UNIQUE NOT NULL,
        Name_ VARCHAR NOT NULL,
        Designation VARCHAR NOT NULL,
        Branch VARCHAR NOT NULL,
        Email VARCHAR NOT NULL UNIQUE,
        Password_ VARCHAR NOT NULL
);
        
        
CREATE TABLE _admin(
        Admin_id INT PRIMARY KEY UNIQUE NOT NULL,
        Name_ VARCHAR NOT NULL,   
        Email VARCHAR NOT NULL UNIQUE,
        Password_ VARCHAR NOT NULL
);
        

CREATE TABLE _category(
        C_id SERIAL PRIMARY KEY UNIQUE NOT NULL,
        Activity_type VARCHAR NOT NULL,
        Level_ INT,
		Points INT,
        Max_points INT NOT NULL
);
        
CREATE TABLE _activity(
        A_id SERIAL PRIMARY KEY UNIQUE NOT NULL,
        Name_ VARCHAR NOT NULL,
        Category VARCHAR NOT NULL,
        Date_ DATE NOT NULL,
        Level_ INT NOT NULL,
        Points INT
);
       
CREATE TABLE _student(
        Roll_No INT NOT NULL PRIMARY KEY UNIQUE,
        Name_ VARCHAR NOT NULL,
        Branch VARCHAR NOT NULL,
        Year_of_Graduation INT NOT NULL,
        Points INT 
);

-- Populating category table

INSERT INTO _category(Activity_type, Level_, Points, Max_points)
VALUES
    ('Sports', 0, 0, 60),
    ('Sports', 1, 8, 60),
    ('Sports', 2, 15, 60),
    ('Sports', 3, 25, 60),
    ('Sports', 4, 40, 60),
    ('Sports', 5, 60, 60),	
    ('Music', 0, 0, 60),
    ('Music', 1, 8, 60),
    ('Music', 2, 12, 60),
    ('Music', 3, 20, 60),
    ('Music', 4, 40, 60),
    ('Music', 5, 60, 60)
;

-- Functions

-- Function to add a new activity

CREATE OR REPLACE FUNCTION add_activity ( name_ VARCHAR, category VARCHAR, date_ DATE, level_ INT)
RETURNS VOID 
AS $$
BEGIN
        INSERT INTO _activity(Name_, Category, Date_, Level_) VALUES (name_, category, date_, level_);
        RAISE NOTICE 'Activity added successfully.';
END;
$$
LANGUAGE plpgsql;

-- Trigger to retrieve points of an activity

CREATE OR REPLACE FUNCTION get_points()
RETURNS TRIGGER
AS $$
BEGIN
        INSERT INTO _activity(Points) VALUES ((SELECT Points FROM _category AS c WHERE new.Category = c.Activity_type AND new.Level_ = c.Level_));
        RETURN new;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER get_points_trigger AFTER INSERT ON _activity
FOR EACH ROW EXECUTE PROCEDURE get_points();

-- To call add_activity

SELECT FROM add_activity( 'Guitar'::VARCHAR, 'Music'::VARCHAR, '2018-02-12'::DATE, 3);

-- Function to add student details

CREATE OR REPLACE FUNCTION add_student( roll_no int, name_ varchar, branch varchar, year_of_graduation int)
RETURNS VOID
AS $$
BEGIN  
        INSERT INTO _student(Roll_No, Name_, Branch, Year_of_Graduation) VALUES (roll_no, name_, branch, year_of_graduation);
        RAISE NOTICE 'Student details added successfully.';
END;
$$
LANGUAGE plpgsql;


-- To call add_student

SELECT FROM add_student(65, 'Vaisakh K'::varchar, 'IT'::varchar, 2020);

-- Function to update student's points

CREATE OR REPLACE FUNCTION update_points( roll_no int, activity varchar)

















