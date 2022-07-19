--8장. set(집합)
select employee_id, job_id
from employees
union
select employee_id, job_id -- 숫자 , 문자 인걸보고 테이블의 구조가 같다는것을 암.
from job_history;  --중복된걸 뺐다.

select employee_id, job_id
from employees
union all
select employee_id, job_id
from job_history;
--union은 중복을 제거 해준다. union all은 싹다 합쳐준다.
--과거의 직업을 현재가지고있는 사람이 2명

-- 과제] 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

select employee_id, job_id
from employees
intersect   --교집합을 뜻함.
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
minus    --차집합
select employee_id, job_id
from job_history;

select location_id, department_name
from departments
union
select location_id, state_province
from locations;
-- 칼럼의 숫자, 문자 순서가 같아서 집합이 가능하다.
-- 퍼시스턴스 관점에서는 문제가 없지만, 
-- 서비스 관점에서 부서명과 도시명이 섞여있다.

-- 과제] 위 문장을, service 관점에서 고쳐라.
--       union을 사용한다.
select location_id, department_name, null state_province
from departments
union
select location_id, null, state_province
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history;  --error

--과제] 위 문장을 persistence 고쳐라.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0    -- 0 대신 null 을 써도됨.
from job_history
order by salary;

