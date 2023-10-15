-- 4. Unnamed PL/SQL code block: Use of Control structure and Exception handling is
-- mandatory.


-- Suggested Problem statement:
-- Consider Tables: 
-- 1. Borrower(Roll_no, Name, DateofIssue, NameofBook, Status) 
-- 2. Fine(Roll_no,Date,Amt)
--  Accept Roll_no and NameofBook from user. 
--  Check the number of days (from date of issue).
--  If days are between 15 to 30 then fine amount will be Rs 5per day.
--  If no. of days>30, per day fine will be Rs 50 per day and for days less than 30, Rs. 5 per day. 
--  After submitting the book, status will change from I to R.
--  If condition of fine is true, then details will be stored into fine table.
--  Also handles the exception by named exception handler or user define exception handler.


DECLARE
    ROLL       NUMBER(3);
    BOOK       VARCHAR(20);
    ISSUE_DATE DATE;
    TEMP       INTEGER;
    FINE       NUMBER;
BEGIN
    ROLL := &ROLL;
    BOOK := '&BOOK';
    SELECT DATEOFISSUE INTO ISSUE_DATE
    FROM BORROWER
    WHERE ROLL_NO = ROLL;
    TEMP := TO_NUMBER(SYSDATE - ISSUE_DATE);
    IF TEMP <= 30 THEN
        INSERT INTO FINE (
            ROLL_NO,
            C_DATE,
            AMT
        ) VALUES (
            ROLL,
            SYSDATE,
            5
        );
        UPDATE BORROWER
        SET
            STATUS = 'R'
        WHERE
            ROLL_NO = ROLL;
    ELSIF TEMP > 30 THEN
        INSERT INTO FINE (
            ROLL_NO,
            C_DATE,
            AMT
        ) VALUES (
            ROLL,
            SYSDATE,
            50
        );
        UPDATE BORROWER
        SET
            STATUS = 'R'
        WHERE
            ROLL_NO = ROLL;
    END IF;
END;
/


-- OR

-- Write a PL/SQL code block to calculate the area of a circle for a value of radius varying from 5 to 9. Store the radius and the corresponding values of calculated area in an empty table named areas, 
-- consisting of two columns, radius and area.
-- Note: Instructor will frame the problem statement for writing PL/SQL block in line with above statement.


DECLARE
  radius NUMBER;
  area NUMBER(10.2);
BEGIN
  dbms_output.put_line('Radius   |  Area of Circle');
  dbms_output.put_line('___________________________');
  FOR radius IN 5..9 LOOP
    area := 3.14 * radius * radius;
    dbms_output.put_line('   ' || radius || '|' || area);
    INSERT INTO areas (radius, area)
    VALUES (radius, area);
  END LOOP;
END;
/
