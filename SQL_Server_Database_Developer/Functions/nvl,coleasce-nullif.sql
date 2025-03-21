create table Student
(studentid varchar(10),
 studentname varchar(10),
 age  int,
 grade varchar(5));

 alter table Student
 alter column age int NULL;


 insert into Student values(1,'Alice',20,'A');
 insert into Student values(2,'Bob',22,'B');
 insert into Student values(3,'Charlie',NULL,'C');
 insert into Student values(4,'David',21,NULL);

---?????? takes exactly two parameters the value to check for null and the replacement value

 /*SELECT studentid, studentname,
 age, NVL(grade, ‘N/A’) AS new_grade FROM student;*/
-- NVL is more specific to Oracle databases--- Oracle methodology

  select * from Student;

 --  ???????????????? can take more than two parameters. It returns the first non-null value among its arguments.
SELECT studentid, studentname, COALESCE(age, 25) as new_age, grade FROM student;

--  ???????????? is used to compare two expressions , if they are equal, NULLIF returns NULL; otherwise, it returns the first expression.
SELECT studentid, studentname, NULLIF(age, 29) AS new_age, grade FROM student;


