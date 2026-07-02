
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BankAccounts';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE StaffMembers';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE BankAccounts (
    AccountNo NUMBER PRIMARY KEY,
    HolderName VARCHAR2(50),
    AccountType VARCHAR2(20),
    Balance NUMBER(10,2)
);

CREATE TABLE StaffMembers (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(50),
    Department VARCHAR2(30),
    Salary NUMBER(10,2)
);


INSERT INTO BankAccounts VALUES (101,'Antariksh','SAVINGS',12000);
INSERT INTO BankAccounts VALUES (102,'Payal','SAVINGS',18000);
INSERT INTO BankAccounts VALUES (103,'Anubhav','CURRENT',25000);
INSERT INTO BankAccounts VALUES (104,'Nehal','SAVINGS',10000);

INSERT INTO StaffMembers VALUES (1,'Ankush','IT',50000);
INSERT INTO StaffMembers VALUES (2,'Riya','HR',42000);
INSERT INTO StaffMembers VALUES (3,'Mohan','IT',55000);
INSERT INTO StaffMembers VALUES (4,'Sonal','Finance',48000);

SELECT AccountNo,
       HolderName,
       AccountType,
       Balance
FROM BankAccounts;
SELECT EmployeeID,
       EmployeeName,
       Department,
       Salary
FROM StaffMembers;
SELECT AccountNo,
       HolderName,
       Balance
FROM BankAccounts;
COMMIT;



CREATE OR REPLACE PROCEDURE ApplyMonthlyInterest
IS
BEGIN
    UPDATE BankAccounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'SAVINGS';

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Monthly interest applied successfully.');
END;
/



CREATE OR REPLACE PROCEDURE GiveDepartmentBonus(
    p_department IN VARCHAR2,
    p_bonus IN NUMBER
)
IS
BEGIN
    UPDATE StaffMembers
    SET Salary = Salary + (Salary * p_bonus / 100)
    WHERE Department = p_department;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Bonus added successfully.');
END;
/


CREATE OR REPLACE PROCEDURE MoveFunds(
    p_fromAccount IN NUMBER,
    p_toAccount IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN

    SELECT Balance
    INTO v_balance
    FROM BankAccounts
    WHERE AccountNo = p_fromAccount;

    IF v_balance >= p_amount THEN

        UPDATE BankAccounts
        SET Balance = Balance - p_amount
        WHERE AccountNo = p_fromAccount;

        UPDATE BankAccounts
        SET Balance = Balance + p_amount
        WHERE AccountNo = p_toAccount;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Transfer completed.');

    ELSE

        DBMS_OUTPUT.PUT_LINE('Insufficient balance.');

    END IF;

END;
/


BEGIN
    ApplyMonthlyInterest;

    GiveDepartmentBonus('IT',10);

    MoveFunds(101,104,2000);
END;
/



SELECT * FROM BankAccounts;

SELECT * FROM StaffMembers;
```
