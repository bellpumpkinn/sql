--2장복습
select employee_id, last_name, department_id
from employees
where department_id = 90; -- department_id의 필드값이 90인거를 골라냄

-- 과제] 176번 사원이 사번, 이름, 부서번호를 조회하라.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen';

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

select last_name, salary
from employees
where salary <= 3000;

--과제] 월 $12,000 이상 버는 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where salary >= 12000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';
---------------------------------------
--범위 조건문
select last_name, salary
from employees
where salary between 2500 and 3500;   --between은 이상, 이하를 나타냄.

select last_name
from employees
where last_name between 'King' and 'Smith';

--과제] 'King'사원의 first name, last name, 직업, 월급을 조회하라.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';
--------------------------------

select employee_id, last_name, manager_id
from employees
where manager_id in(100, 101, 201);  --in을 or로 바꿔서 해도된다.

select employee_id, last_name, manager_id
from employees
where manager_id = 100 or   
      manager_id = 101 or
      manager_id = 201;
      
select employee_id, last_name
from employees
where last_name in('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');
-------------------------------------------------------

select last_name
from employees
where last_name like 'S%';  -- S로 시작하는 애들을 찾는다.

select last_name
from employees
where last_name like '%r'; -- r로 끝나는 애들을 찾는다.

--과제] first_name에 s가 포함된 사원들을 조회하라.
select last_name, first_name
from employees
where first_name like '%s%';

-- 과제] 2005년에 입사한 사원들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where hire_date like '2005%';
--연산자를 쓰려면 피연산자의 데이터타입이 같아야한다.
--와일드카드%는 글자수가 0개이상이다. 임의의 0개이상의 글자를 뜻한다.

-- _(언더스코어)는 임의의 한글자.
select last_name
from employees
where last_name like 'K___'; --K로 시작하는 4글자가 나와야함
--검색할때 like를 쓴다.

--과제] 이름의 두번째 글자가 o인 사원의 이름을 조회하라.
select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; --이스케이프문자쓰려면 escape해주면됨.
-- \_는 _가 문자라는걸 알려준다.

select last_name, job_id
from employees
where job_id like 'IT[_%' escape '[';

--과제] 직업에 _R이 포함된 사원들의 이름, 직업을 조회하라.
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';
------------------------------------------------------

select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null;  --null이 있으면 null이기때문에 아무것도 안뜸.

--null만을 위한 연산자.  is null을 써야함
select last_name, manager_id
from employees
where manager_id is null;  --is null을 쓰면 뜬다.
------------------------------------------------------
-- and와 or 연산자
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';

--과제] 월급이 $5000 이상 $12000 이하이고,
--     20번이나 50번 부서에서 일하는 사원들의 이름, 월급, 부서번호를 조회하라.
select last_name, salary, department_id
from employees
where salary between 5000 and 12000 and
      department_id in(20, 50);

-- 과제] 이름에 a와 e가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%a%' and
      last_name like '%e%';
--------------------------------------------------
--not 연산자 (not은 여집합을 구하는것.)

select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP');

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

select last_name, job_id
from employees
where commission_pct is not null;

select last_name, salary
from employees
where manager_id is null and salary >=20000;

select last_name, salary
from employees
where not(manager_id is null and salary >=20000);

--과제] 직업이 영업이다. 그리고, 월급이 $2500, $3500가 아니다.
--     위 사원들의 이름, 직업, 월급을 조회하라.

select last_name, job_id, salary
from employees
where job_id like '%SA%' and
    salary not in (2500, 3500);







