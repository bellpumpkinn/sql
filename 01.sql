--1장 select --이게 주석임

select * from departments; --테이블병은 복수형. 칼럼네임은 단수형
--select * from : 모든칼럼을 조회

select department_id, location_id --레코드의 타입 또는 테이블 타입이 될수있음.
from departments;  -- 특정 칼럼만 받고싶을때.

select location_id, department_id
from departments;  --내 맘대로 칼럼순서 정하기 가능.

desc departments --departments의 구조확인.

-- 과제] employees 구조를 확인하라.
desc employees

select last_name, salary, salary + 300 --익스프레션: 값을 나타내는거
from employees;

-- 과제] 사원들의 월급, 연봉을 조회하라.

select salary, salary * 12
from employees;

--우선순위.
select last_name, salary, 12 * salary + 100
from employees;
select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;
select last_name, job_id, (12 * salary)*(1 + commission_pct)
from employees; --커미션 안받는애들은 연봉안뜸. null이 있어서 그럼.

--칼럼이름을 바꾸기.(별명)
select last_name as name, commission_pct comm --as는 생략가능
from employees;
--대소문자 집어넣고 싶으면 ""사용
select last_name as "Name", 12 * salary "Annual Salary"
from employees;

-- 과제] 사원들의 사번, 이름, 직업, 입사일(STARTDATE)을 조회하라.
select employee_id, last_name, job_id, hire_date startdate
from employees;

-- 과제] 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

select last_name || job_id
from employees;  --하나의 칼럼으로 붙이는법 ||사용
select last_name || ' is ' || job_id
from employees; 
select last_name || ' is ' || job_id employee
from employees; 
select last_name || null --null은 null이 아닌 문자 null로 받아들임.
from employees;
select last_name || commission_pct
from employees;   --숫자가 문자가되서 문자로 붙음
select last_name || salary   
from employees;   --문자 24000이 되서 문자king24000이 됨.
select last_name || hire_date   
from employees;   --날짜도 문자가 되서 문자로 붙음.
select last_name || (salary * 12)
from employees;

--과제] 사원들의 '이름, 직업'(Emp and Title)을 조회하라.
select last_name || ', ' || job_id "Emp and Title"
from employees;



