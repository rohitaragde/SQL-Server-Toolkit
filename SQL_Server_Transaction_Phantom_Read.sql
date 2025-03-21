-------------------------------- Phantom Reads -------------------------------

/*
Phantom Read happens when one transaction executes a query twice and it gets a different 
number of rows in the resultset each time. This happens when a second transaction inserts
a new row that matches the where clause of the query executed by the first transaction.


Transaction 01          Transaction 02

Read 01: 
select * from emp
where id between
1 and 3
Output: 2 rows

Doing some work				Insert a new employee with id=2

Read 02:
select * from emp
where id between
1 and 3
Output:3 rows

*/

--select * from TranEmp
------------------------------------ Transaction 01 -----------------------------------------
---set transaction isolation level serializable 
Begin Transaction

select * from TranEmp
where id between 1 and 3

waitfor delay '00:00:10'

select * from TranEmp
where id between 1 and 3

commit transaction

------------------------------------------- Transaction 02 --------------------------------------

insert into TranEmp values(2,'Marcus')

---delete from tranemp where id=2


/* 

When we execute both the transactions simultaneously we get different number of rows in 
both the reads in transaction 01 as transaction 02 was allowed to insert while transaction 01
was still executing and hence different set of rows this is called phantom read problem.

id	nname
1	Mark
3	Sara

id	nname
1	Mark
2	Marcus
3	Sara

*/

/* to fix this problem we set the transaction isolation level for transaction 01 as serializable.
Note that only serializable and snapshot isolation do not have this problem.

When we set the transaction isolation level to serializable in transaction 01, 
transaction 02 is blocked until transaction 1 finishes and is allowed to insert
only when transaction 1 finishes and hence it gives same number of rows for
both the reads in transaction 01 and hence setting the transaction isolation
level to serializable solves the plantom read problem.

Setting transaction 1 isolation to serializable placed a range lock on the rows
between 1 and 3, which prevents any other transaction from inserting any new
rows in that range.
*/

/* 
			Repeatable Read VS Serializable Isolation Levels


Repeatable read prevents only non-repeatable read. Repeatable read isolation level ensures that 
the data that one transaction has read, will be prevented from being updated or deleted by any
other transaction, but it does not prevent new rows from being inserted by other transactions
resulting in phantom read concurrency problem.

Serializable prevents both non-repeatable read and phantom read problems. Serializable isolation
level ensures that the data that one transaction has read will be preveented from being updated or
deleted by any other transaction. it also prevents new rows from being inserted by other transactions,
so this isolation level prevents both non-repeatable read and phantom read problems.

*/









