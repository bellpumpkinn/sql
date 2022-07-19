--6장 join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join(이퀴조인에 네츄럴 조인이 있는거.)
select department_id, department_name, location_id, city
from departments natural join locations;  --각부서가 어디에있는지 알수있음.
-- join : 레코드를 결합시키는거임.

--natural join: 양쪽테이블의 공통된칼럼을 찾는다. 
--공통된칼럼의 필드값이 같은것들을 join시킨다.
--location에서는 location_id가 프라이머리키. departmens에서 로케이션id는 폴인 이라고 한다.
--폴인(외부에서 들어오는거).보통 조인이 될만한거에는 한쪽은 프라이머리키(pk), 한쪽은 폴인키(fk)
--테이블설계도 없이는 좀 힘듬(공통칼럼이 드러나있지않아서). 그래서 잘 안씀.

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

--using
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id); --department_id가 같은애들끼리 조인을 하겠다.

-- 과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments;
------------------------------------------------------------------------

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

--접두사
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;   --테이블에도 별명을 붙일수 있다.

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400;  --error. using절의 칼럼에 접두사를 붙였다.
--using절의 칼럼은 접두사를 가지지 못한다.

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; --error. using칼럼에는 접두사를 붙이지 못한다.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100; --error. manager_id가 무슨칼럼인지 애매하다는 에러.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where e.manager_id = 100; --접두사를 붙여주니 작동이 잘됨.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100;    --접두사를 붙이지 않는건 using칼럼
--using이 아닌 공통칼럼에는 접두사를 붙여야한다.
---------------------------------------------------

--on안에다가 조건문
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

--과제] 위 문장을, using으로 refactoring 하라.
select employee_id, city, department_name
from employees e join departments d
using(department_id)
join locations l
using(location_id);

--using에서 where을 써서 골라냈음
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id --on과 where 조건이 2개.
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id  --on에서는 내가 연산자를 고를수있겠다.
and e.manager_id = 149;  --위에거를 이렇게 리팩토링 가능.

-- 과제] Toronto 에 위치한 부서에서 일하는 사원들의 
--      이름, 직업, 부서번호, 부서명, 도시를 조회하라.
select e.last_name, e.job_id, e.department_id, 
      d.department_name, l.city
from employees e join departments d   
on e.department_id = d.department_id   -- department_id가 같다가 조건.
join locations l
on d.location_id = l.location_id  
and l.city = 'Toronto';

--non-equi join
--프로그래머만큼 돈을 받는친구들 알아보기.
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-------------------------------------------------------

--self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; --error. 어떤칼럼인지 모르겠다는 에러.

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;  --error. self join을 하는순간 접두사가 필수.

-- 과제] 같은 부서에서 일하는 사원들의 이름, 부서번호, 동료의 이름을 조회하라.
select e.department_id, e.last_name employee , c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id != c.employee_id    -- <>는 !=  와 같다.
order by 1, 2 ,3;

-- 과제] Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date, c.last_name, c.hire_date
from employees e join employees c
on c.hire_date between e.hire_date and sysdate
and e.last_name = 'Davies'
and c.last_name != 'Davies'
order by 4, 3;
--아래 코드가 강사님 코드
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date
order by 2;

-- 과제] 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저입사일을 조회하라.
select w.last_name, w.hire_date, m.last_name, m.hire_date
from employees w join employees m
on w.manager_id = m.employee_id   --워커의 매니저번호가 매니저의 직원번호와 같으면
and m.hire_date > w.hire_date;
--------------------------------여태까지 한 join은 inner join이라고 한다.

--outer join

select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id; --grant하나가 빠졌었는데 붙었음.

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;  --department에서 조인안된게 붙음.

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;  --양쪽다 붙이고 싶을때  full outer join사용.

-- 과제] 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
--      king 사장도 테이블에 포함한다.
select w.last_name, w.employee_id, m.last_name, m.employee_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;
---------------------------------------------6장의 1부 끝.
--2부.

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in(20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id; --d테이블을 중심에 두고 e와 l을 연결

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;  --right outer조건문
--왼쪽에 (+)를 하면 right outer 조건문
--오른쪽에 (+)를 하면 left outer 조건문.
--full outer join은 없다.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--self join
select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;   

