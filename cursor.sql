-- Cursors: (All types: Implicit, Explicit, Cursor FOR Loop, Parameterized Cursor)
-- Write a PL/SQL block of code using parameterized Cursor that will merge the data availablein 
-- the newly created table N_RollCall with the data available in the table O_RollCall. If the data in 
-- the first table already exist in the second table then that data should be skipped.

-- implicit cursor

BEGIN
    UPDATE O_ROLLCALL
    SET
        STATUS='Present'
    WHERE
        ROLL_NO=13;
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Updated');
    END IF;
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Not updated - not found');
    END IF;
    IF SQL%ROWCOUNT>0 THEN
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT
                                 ||'rows updated');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No rows updated');
    END IF;
END;
/

-- explicit

DECLARE
    CURSOR EXPLICIT_CUR IS
        SELECT
            ROLL_NO,
            NAME,
            STATUS
        FROM
            O_ROLLCALL
        WHERE
            STATUS='Present';
    TEMP EXPLICIT_CUR%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Explicit Cursor');
    OPEN EXPLICIT_CUR;
    LOOP
        EXIT WHEN EXPLICIT_CUR%NOTFOUND;
        FETCH EXPLICIT_CUR INTO TEMP;
        DBMS_OUTPUT.PUT_LINE('     ROLLNO:       '
                             || TEMP.ROLL_NO
                             || '     NAME:       '
                             ||TEMP.NAME
                             ||'    STATUS:      '
                             ||TEMP.STATUS);
    END LOOP;
    IF EXPLICIT_CUR%ROWCOUNT>0 THEN
        DBMS_OUTPUT.PUT_LINE(EXPLICIT_CUR%ROWCOUNT
                                          ||'Rows found');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No Rows Found');
    END IF;
    CLOSE EXPLICIT_CUR;
END;
/

-- FOR LOOP CURSOR

DECLARE
    CURSOR FOR_CUR IS
        SELECT
            ROLL_NO,
            NAME,
            STATUS
        FROM
            O_ROLLCALL
        WHERE
            STATUS='Present';
    TEMP FOR_CUR%ROWTYPE;
BEGIN
    FOR TEMP IN FOR_CUR LOOP
        DBMS_OUTPUT.PUT_LINE ('  ROLLNO:  '
                              ||TEMP.ROLL_NO
                              ||''
                              ||'   Name:  '
                              ||TEMP.NAME
                              ||''
                              ||'   Status: '
                              ||TEMP.STATUS);
    END LOOP;
END;
/

-- PARAMETERIZED CURSOR

DECLARE
    ROLL NUMBER;
    CURSOR PARAM_CUR(ROLL NUMBER) IS
        SELECT
            *
        FROM
            O_ROLLCALL
        WHERE
            ROLL_NO=ROLL;
    TEMP PARAM_CUR%ROWTYPE;
BEGIN
    ROLL:=&ROLL;
    FOR TEMP IN PARAM_CUR(ROLL) LOOP
        DBMS_OUTPUT.PUT_LINE('Roll No: '
                             ||TEMP.ROLL_NO);
        DBMS_OUTPUT.PUT_LINE('Name: '
                             ||TEMP.NAME);
        DBMS_OUTPUT.PUT_LINE('Status: '
                             ||TEMP.STATUS);
    END LOOP;
END;
/

-- MERGE

BEGIN
    MERGE INTO N_ROLLCALL T1 USING (
        SELECT
            ROLL_NO,
            NAME,
            STATUS
        FROM
            O_ROLLCALL
    ) T2 ON (T1.ROLL_NO=T2.ROLL_NO) WHEN NOT MATCHED THEN INSERT VALUES(T2.ROLL_NO, T2.NAME, T2.STATUS);
    IF SQL%ROWCOUNT>0 THEN
        DBMS_OUTPUT.PUT_LINE('Merged, '
                             ||SQL%ROWCOUNT
                             ||' Rows Updated');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No Rows Updated');
    END IF;
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Not Merged');
    END IF;
END;
/