------------------------------------ Session 2 ---------------------------------------

Begin Transaction;

UPDATE invoice_items
SET amount = 100
WHERE id = 10;

----------------- Blocked since Session 1 is updated but not yet committed the transaction ----
UPDATE invoices
SET total = (SELECT
SUM(amount * (1 + tax))
FROM invoice_items
WHERE invoice_id = 1)
WHERE id = 1;

/*Hence, this blocks both and creates a deadlock */