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
    student_name VARCHAR2(50) := 'John Doe';
    student_marks NUMBER := 950;
    
BEGIN
    proc_Grade(student_name, student_marks);  
    DBMS_OUTPUT.PUT_LINE('Student ' || student_name || ' has been categorized.');  
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
