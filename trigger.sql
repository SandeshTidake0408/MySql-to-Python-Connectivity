-- 7. Database Trigger (All Types: Row level and Statement level triggers, Before and After
-- Triggers).
-- Write a database trigger on Library table. The System should keep track of the records that are 
-- being updated or deleted. The old value of updated or deleted records should be added in
-- Library_Audit table.

CREATE OR REPLACE TRIGGER BOOKSTORE
    AFTER
    INSERT OR UPDATE OR DELETE ON LIBRARY
    FOR EACH ROW
    ENABLE
BEGIN
    IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE(:OLD.STATUS || ' UPDATING');
        INSERT INTO LIBRARY_AUDIT VALUES(
            SYSDATE,
            :OLD.BOOK_NAME,
            :OLD.STATUS,
            :NEW.STATUS,
            'Update'
        );
    ELSIF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE(:NEW.BOOK_NAME || ' Inserting');
        INSERT INTO LIBRARY_AUDIT VALUES(
            SYSDATE,
            :NEW.BOOK_NAME,
            NULL,
            :NW.STATUS,E
            'Insert'
        );
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE(:OLD.BOOK_NAME
                                  || ' Deleting');
        INSERT INTO LIBRARY_AUDIT VALUES(
            SYSDATE,
            :OLD.BOOK_NAME,
            :OLD.STATUS,
            NULL,
            'Delete'
        );
    END IF;
END;
/