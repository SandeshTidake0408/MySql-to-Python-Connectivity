-- 5. Named PL/SQL Block: PL/SQL Stored Procedure and Stored Function.
-- Write a Stored Procedure namely proc_Grade for the categorization of student. If marks scoredby 
-- students in examination is <=1500 and marks>=990 then student will be placed in distinction 
-- category if marks scored are between 989 and 900 category is first class, if marks 899 and 825 
-- category is Higher Second Class.
-- Write a PL/SQL block to use procedure created with above requirement.
-- Stud_Marks(name, total_marks) Result(Roll,Name, Class)
-- Note: Instructor will frame the problem statement for writing stored procedure and Function in 
-- line with above statement.

CREATE TABLE Stud_Marks (
    Roll NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Total_Marks NUMBER
);

CREATE TABLE Result (
    Roll NUMBER,
    Name VARCHAR2(50),
    Class VARCHAR2(50)
);

-- Sample data for Stud_Marks table
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('John Doe', 1000);
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('Jane Smith', 950);
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('Bob Johnson', 875);
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('Alice Brown', 1100);
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('Charlie White', 1400);


CREATE OR REPLACE PROCEDURE proc_Grade (name IN VARCHAR2, total_marks IN NUMBER) AS
    class VARCHAR2(50);
BEGIN
    insert into Stud_Marks (name, total_marks) values (name,total_marks);
    IF total_marks <= 1500 AND total_marks >= 990 THEN
        class := 'Distinction';
    ELSIF total_marks BETWEEN 900 AND 989 THEN
        class := 'First Class';
    ELSIF total_marks BETWEEN 825 AND 899 THEN
        class := 'Higher Second Class';
    ELSE
        class := 'Fail'; 
    END IF;
    INSERT INTO Result (Name, Class) VALUES (name, class);   
END;
/

--To excute above procedure execute following unnamed block

DECLARE
    student_name VARCHAR2(50) ;
    student_marks NUMBER;
    
BEGIN
    student_name := '&student_name';
    student_marks := &student_marks;
    proc_Grade(student_name, student_marks);  
    DBMS_OUTPUT.PUT_LINE('Student ' || student_name || ' has been categorized.');  
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
