----------------------------------- SQL Server Deadlock -------------------------------------------

/*

A deadlock is a concurrency problem in which two sessions block the progress of each other.
The first session has a lock on a resource that the other session wants to access, and vice versa.

In this picture, the invoices and invoice_items are tables.

First, session one accesses the invoices table and locks it.
Second, session two locks the invoice_items table and locks it.
Third, session one wants to access the invoice_items table but needs to wait for session two complete.
At the same time, session two wants to access the invoices table but needs to wait for session two
to complete.
As the result, two sessions are waiting for each other until SQL Server proactively
terminates one of them. The session that is terminated by SQL Server is called a deadlock victim.

*/

----------------------------- SQL Server Deadlock Example -----------------------------------

/* Let’s take a look at an example of creating a deadlock.
In this example, we’ll first create the invoices and invoice_items tables: */

CREATE TABLE invoices (
  id int IDENTITY PRIMARY KEY,
  customer_id int NOT NULL,
  total decimal(10, 2) NOT NULL DEFAULT 0 CHECK (total >= 0)
);

CREATE TABLE invoice_items (
  id int,
  invoice_id int NOT NULL,
  item_name varchar(100) NOT NULL,
  amount decimal(10, 2) NOT NULL CHECK (amount >= 0),
  tax decimal(4, 2) NOT NULL CHECK (tax >= 0),
  PRIMARY KEY (id, invoice_id),
  FOREIGN KEY (invoice_id) REFERENCES invoices (id)
     ON UPDATE CASCADE
     ON DELETE CASCADE
);

INSERT INTO invoices (customer_id, total)
  VALUES (100, 0);

INSERT INTO invoice_items (id, invoice_id, item_name, amount, tax)
  VALUES (10, 1, 'Keyboard', 70, 0.08),
  (20, 1, 'Mouse', 50, 0.08);

UPDATE invoices
SET total = (SELECT
  SUM(amount * (1 + tax))
  FROM invoice_items
  WHERE invoice_id = 1
);

/* Then, we’ll create two sessions to connect to the database. 
Here’s the sequence of statements that you need to execute from each session.
*/

/*
Once a deadlock occurs, SQL Server will kill a deadlock victim. 
*/

/*
Msg 1205, Level 13, State 51, Line 9
Transaction (Process ID 57) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction.

Completion time: 2024-10-30T21:09:13.4293660-04:00
*/

/*
SQL Server deadlock is a problem in which two sessions lock on a resource that the 
other session wants to access and vice versa.
*/

