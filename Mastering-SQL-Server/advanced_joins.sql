--------------- Advanced or Intelligent Joins -------------------------------

select * from tblEmployee;

select * from tblDepartment;

--- Only Non matching rows from the left table -------

select empname,gender,salary,departmentname
from tblEmployee e left join tblDepartment d
on e.departmentid=d.deptid
where d.deptid is null;


--- Only Non Matching rows from the right table------

select empname,gender,salary,departmentname
from tblEmployee e right join tblDepartment d
on e.departmentid=d.deptid
where e.departmentid is null;

--- Non Matching rows from both the tables ---------
 /*
 cannot use = when comparing nulls always use is null.
 */

select empname,gender,salary,departmentname
from tblEmployee e  full outer join tblDepartment d
on e.departmentid=d.deptid
where e.departmentid is null
or d.deptid is null;



