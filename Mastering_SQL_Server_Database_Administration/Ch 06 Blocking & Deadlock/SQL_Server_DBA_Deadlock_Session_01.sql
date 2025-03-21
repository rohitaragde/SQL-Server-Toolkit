-------------------------------------- Session 1 -------------------------------------

Begin Transaction;

UPDATE invoices
SET customer_id = 100
WHERE id = 1;

----------------- Blocked since Session 2 is updated but not yet committed the transaction -----
UPDATE invoice_items
SET item_name = 'Cool Keyboard'
WHERE id = 10; 

select * from invoices
select * from invoice_items 