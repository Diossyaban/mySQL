-- NO 1 informasi jumlah department di tiap regions.
select r.region_id, r.region_name, count (d.department_id) as total_departments
from hr.regions r
join hr.countries c on r.region_id =c.region_id
join hr.locations l on c.country_id = l.country_id 
join hr.departments d on l.location_id  = d.location_id
group by  r.region_id, r.region_name

-- NO 2 Informai jumlah department tiap countries.
select c.country_id, c.country_name, count (d.department_id) as total_departments
from hr.countries c
join hr.locations l on c.country_id = l.country_id
join hr.departments d on l.location_id = d.location_id
group by  c.country_id, c.country_name


--4. Informasi jumlah employee tiap region.

select r.region_id, r.region_name, count (e.employee_id) as total_employee
from hr.regions r 
right join hr.countries c on r.region_id = c.region_id
right join hr.locations l on c.country_id = l.country_id
right join hr.departments d on l.location_id = d.location_id
right join hr.employees e on d.department_id = e.department_id
group by r.region_id, r.region_name

-- 5 Informasi jumlah employee tiap countries.

select c.country_id, c.country_id, count (e.employee_id) as total_employee
from hr.countries c
right join hr.locations l on c.country_id = l.country_id
right join hr.departments d on l.location_id = d.location_id
right join hr.employees e on d.department_id = e.department_id
group by c.country_id, c.country_name

--6. Informasi salary tertinggi tiap department.
select d.department_id, department_name , max (j.max_salary) as salary_tertinggi
from hr.jobs j
join hr.employees e on j.job_id = e.job_id
join hr.departments d on e.department_id = d.department_id
group by d.department_id , d.department_name
order by salary_tertinggi asc

--7. Informasi salary terendah tiap department.
select d.department_id, department_name , min (j.min_salary) as salary_terendah
from hr.jobs j
right join hr.employees e on j.job_id = e.job_id
right join hr.departments d on e.department_id = d.department_id
group by d.department_id , d.department_name
order by salary_terendah asc


--8. Informasi salary rata-rata tiap department.
select d.department_id, department_name , avg (e.salary) as rata2_salary
from hr.jobs j
join hr.employees e on j.job_id = e.job_id
join hr.departments d on e.department_id = d.department_id
group by d.department_id , d.department_name, e.job_id
order by rata2_salary asc

--9. Informasi jumlah mutasi pegawai tiap deparment.

select d.department_id, COUNT(e.employee_id) as Jumlah_mutasi
from hr.departments d
join hr.employees e on d.department_id =e.department_id
join hr.job_history j on e.employee_id = e.employee_id
group by d.department_id, department_name

---10.Informasi jumlah mutasi pegawai berdasarkan role-jobs.

select e.job_id, COUNT(e.employee_id) as jumlah_mutasi_pegawai
from hr.departments d
join hr.employees e on d.department_id = e.department_id
join hr.job_history j on e.employee_id = e.employee_id
group by e.job_id


---11.Informasi jumlah employee yang sering dimutasi.


---12.Informasi jumlah employee berdasarkan role jobs-nya.
select sum (t.employee) from ( 
select j.job_title, count (employee_id) as employee from hr.employees e 
join hr.jobs j on e.job_id = j.job_id
group by j.job_title ) t

select*from hr.jobs

--13.Informasi employee paling lama bekerja di tiap deparment.

select d.department_id, department_name, employee_id, first_name, DATEDIFF (YY,HIRE_DATE,GETDATE()) lama_kerja, min(hire_date) as paling_lama
from hr.departments d
inner join hr.employees e on d.department_id=e.department_id
group by d.department_id, department_name, employee_id, first_name, hire_date


--14.Informasi employee baru masuk kerja di tiap department.
with cte as (
select 
DEPARTMENT_ID,
EMPLOYEE_ID,FIRST_NAME,HIRE_DATE,DATEDIFF(YY,HIRE_DATE,GETDATE())as lama_kerja
from hr.EMPLOYEES
where DEPARTMENT_ID is not null
)
select * from cte a join 
(select DEPARTMENT_ID,min(lama_kerja)as lama_kerja from cte group by DEPARTMENT_ID)b
on a.DEPARTMENT_ID=b.DEPARTMENT_ID and a.lama_kerja=b.lama_kerja



---15.Informasi lama bekerja tiap employee dalam tahun dan jumlah mutasi history-nya.