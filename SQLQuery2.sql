select* from hr.employees where job_id='IT_prog'

select* from hr.employees where salary between 7000 and 10000

select * from hr.employees where  salary >= 7000 and salary <=10000
select * from hr.employees where  department_id is null

select * from hr.employees where job_id in ('IT-Prog','fi_account') and (salary >=7000 and salary <=10000)

--operator like--

select * from hr.employees where first_name like 'J&'



--SQL JOIN--
select * into empA from hr.employees where employee_id in ( 100,101,102)

select*from empA

select * into EmpB from hr.employees where employee_id in (101,103,104,105)

select * From EmpB

--inner join
select * From EmpA a join EmpB b on a.employee_id=b.employee_id

--left Join
select a.* from	EmpA a left join EmpB b on a.employee_id=b.employee_id

select a.* from EmpA a left join EmpB b on a.employee_id=b.employee_id
where b.employee_id is null

--right Join
select b.* from	EmpA a right join EmpB b on a.employee_id=b.employee_id

select b.* from EmpA a right join EmpB b on a.employee_id=b.employee_id
where a.employee_id is null

--full outer Join--
select * from EmpA a full outer join EmpB b on a.employee_id=b.employee_id 

select * from EmpA a full outer join EmpB b on a.employee_id=b.employee_id
where a.employee_id is null or b.employee_id is null

--countries and location --
select * from hr.countries c left join hr.locations l
	on c.country_id=l.country_id 
	where l.location_id is null


select * from hr.countries where country_id not in(
select distinct c.country_id 
from hr.countries c join hr.locations l
	on c.country_id=l.country_id 
);
--aggregate
select min(salary) as min_salary, max(salary) as max_salary from hr.employees

select max(hire_date)as lama_kerja from hr.employees

select min(hire_date)as lama, max(hire_date)as baru from hr.employees

select * from hr.employees where hire_date = (select max(hire_date) from hr.employees)

select avg(salary)as avg_salary from hr.employees where department_id=90

select department_id, count (job_id)total_job
from hr.employees
group by department_id
having count(job_id) > 5

--tampilkan jumlah total emp tiap department
select d.department_id,department_name,count(employee_id) as total_employee
from hr.departments d join hr.employees e on d.department_id=e.department_id
group by d.department_id,department_name
order by department_name

--sum
select sum(t.total_employee)as jumlah from(
select d.department_id,department_name,count(employee_id) as total_employee
from hr.departments d join hr.employees e on d.department_id=e.department_id
group by d.department_id,department_name)t


--datetime

select employee_id,first_name,hire_date,year(hire_date) as tahun, month(hire_date) as bulan,
day(hire_date) as day
from hr.employees

select employee_id,first_name,hire_date,datediff(yy,hire_date,Getdate())Lama_kerja
from hr.employees