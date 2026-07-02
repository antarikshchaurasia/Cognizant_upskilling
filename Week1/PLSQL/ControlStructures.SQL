CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(50),
    Age NUMBER,
    Balance NUMBER,
    IsVIP VARCHAR2(5)
);
CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    InterestRate NUMBER,
    DueDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Customers VALUES (101,'Antariksh',65,19000,'FALSE');
INSERT INTO Customers VALUES (102,'Ravi',45,7000,'FALSE');
INSERT INTO Customers VALUES (103,'Suman',70,35000,'FALSE');
INSERT INTO Customers VALUES (104,'Lala',35,14000,'FALSE');

INSERT INTO Loans VALUES (1,101,9, SYSDATE+10);
INSERT INTO Loans VALUES (2,102,11,SYSDATE+35);
INSERT INTO Loans VALUES (3,103,8,SYSDATE+40);
INSERT INTO Loans VALUES (4,104,10,SYSDATE+50);



SELECT CustomerID, InterestRate
FROM Loans;
SELECT CustomerID, CustomerName, Balance, IsVIP
FROM Customers;
SELECT * FROM Customers;
SELECT * FROM Loans;

COMMIT;


BEGIN


    FOR c IN (
        SELECT CustomerID
        FROM Customers
        WHERE Age > 60
    )
    LOOP
        UPDATE Loans
        SET InterestRate = InterestRate - 1
        WHERE CustomerID = c.CustomerID;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Scenario 1 Completed');


    FOR c IN (
        SELECT CustomerID
        FROM Customers
        WHERE Balance > 10000
    )
    LOOP
        UPDATE Customers
        SET IsVIP='TRUE'
        WHERE CustomerID=c.CustomerID;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Scenario 2 Completed');


    FOR l IN (
        SELECT LoanID,CustomerID,DueDate
        FROM Loans
        WHERE DueDate BETWEEN SYSDATE AND SYSDATE+30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder: Customer '
            || l.CustomerID ||
            ' Loan '
            || l.LoanID ||
            ' is due on '
            || TO_CHAR(l.DueDate,'DD-MON-YYYY')
        );
    END LOOP;

    COMMIT;

END;
/
```
