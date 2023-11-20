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