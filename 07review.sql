--7장. subquery
--서브쿼리가 값을 내면 메인이 이용한다.

select last_name, salary
from employees
where salary > (select salary
                    from employees
                    where last_name = 'Abel');
--메인쿼리는 11000보다 크다를 뽑아낸거.
--서브쿼리는 갯수제한이 없다.

-- 과제] kochhar 에게 보고하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where manager_id = (select manager_id
                        from employees
                        where last_name = 'Kochhar');

select last_name, job_id, salary
from employees
where job_id = (select job_id
                    from employees
                    where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');

-- 과제] Abel과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by 1;

select last_name, salary
from employees
where salary > (select salary
                    from employees
                    where last_name = 'King'); --error.
--서브쿼리의 리턴값은 하나다. 하지만 위에선 2개의 리턴값을 내보냄.

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);

select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);

-- 과제] 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
--      월급 내림차순 정렬한다.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by 3 desc;
------------------------------------------------------

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees); --서브쿼리가 1개를 리턴해서 잘 작동.
                
select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); --error. 서브쿼리가 1개이상을 리턴함.

select employee_id, last_name
from employees
where salary in (select min(salary)
                from employees
                group by department_id); 
--서브쿼리의 리턴값이 12개인데 in을쓰면 잘작동됨.

-- 과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in (select department_id
                            from employees
                            where last_name like '%u%');

--과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = '1700');

select employee_id, last_name
from employees
where salary =any (select min(salary)
                     from employees
                     group by department_id); 
-- in을 =any로 바꿀수있음.  any는 하나만 해당하면 다 나타낸다.  

select employee_id, last_name, job_id, salary
from employees
where salary < any(select salary
                    from employees
                    where job_id = 'IT_PROG')--9000미만이면 true가 됨.
and job_id <> 'IT_PROG'; -- any는 하나만 true이면 true가 됨.

select employee_id, last_name, job_id, salary
from employees
where salary < all(select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG'; 
--all은 모두다 true가 되야함. 즉 4200미만이면 true가 됨.       




