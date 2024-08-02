---------------- Refrential Integrity on delete cascade -------------------

/*For Refrential Integrity:-
a) No Action:- this is the default behavior,that means if you try to delete or update 
a row it will throw an error.
b) Cascade:- In cascade , if you try to update or delete a row with a key referenced
by foreign keys in existing rows in other tables, all rows containing those foreign keys
will also be deleted or updated.
c) Set NULL:- specifies that if you try to update or delete a row with a key referenced
by foreign keys in existing rows in other tables all rows containing those foreign keys
will be set to NULL
d) Set Default:- specifies that if you try to update or delete a row with a key referenced
by foreign keys in existing rows in other tables all rows containing those foreign keys
will be set to default values.*/

select * from tblGender;
select * from tblPerson;

-- No Action---
ALTER TABLE tblPerson
ADD CONSTRAINT fk_genderid_Person
FOREIGN KEY (genderId)
REFERENCES tblGender(id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

--- On Delete cascade ----
delete from tblGender where id=1;

ALTER TABLE tblPerson
ADD CONSTRAINT fk_genderid_Person
FOREIGN KEY (genderId)
REFERENCES tblGender(id)
ON DELETE CASCADE;

----- Set NULL----
ALTER TABLE tblPerson
ADD CONSTRAINT fk_genderid_Person
FOREIGN KEY (genderId)
REFERENCES tblGender(id)
ON DELETE SET NULL
ON UPDATE SET NULL;

----- Set Default-------
ALTER TABLE tblPerson
ALTER COLUMN genderId SET DEFAULT 0;

ALTER TABLE tblPerson
ADD CONSTRAINT fk_genderid_Person
FOREIGN KEY (genderId)
REFERENCES tblGender(id)
ON DELETE SET DEFAULT
ON UPDATE SET DEFAULT;



-------------------------- Check Constraint-----------------------------------

/* Check constraint is used to limit the range of the values,
that can be entered for a column

Alter table tablename
add contraint constraintname check(boolean expression)

If the boolean expression returns true the check constriant allows the value otherwise it dosent.
*/


select * from tblGender;
select * from tblPerson;

alter table tblPerson
add constraint CK_tblPerson_Age check(age>0 and age<150);

insert into tblPerson values(6,'Ross','ro@ro.com',2,950);



