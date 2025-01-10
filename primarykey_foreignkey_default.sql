---------------------- Primary Key, Foreign Key and Default Constraint------------


use [TUT]

create table tblGender
( id int primary key,
 gender nvarchar(50) not null);

 insert into tblGender values(1,'Male')
 insert into tblGender values(2,'Female')
 insert into tblGender values(3,'Unknown')

 create table tblPerson
 (id int primary key,
  nname nvarchar(10),
  email nvarchar(10),
  genderid int,
  foreign key(genderid) references tblGender(id));

  insert into tblPerson values(1,'John','j@j.com',1);
  insert into tblPerson values(2,'Mary','m@m.com',NULL);
  insert into tblPerson values(3,'Simon','s@s.com',1);
  insert into tblPerson values(4,'Sam','sam@sam.com',1);
  insert into tblPerson values(5,'May','may@may.com',2);
  insert into tblPerson values(6,'kenny','k@k.com',3);

  insert into tblPerson(ID,nname,email,genderid) values(9,'Sara','s@r.com',1);
  insert into tblPerson(ID,nname,email,genderid) values(10,'Johnny','j@r.com',NULL)

  alter table tblPerson
  add constraint DF_tblPerson_GenderId
  DEFAULT 3 FOR GENDERID

  select * from tblGender;
  select * from tblPerson;






