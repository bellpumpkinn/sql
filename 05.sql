--5장 group function
--single function은 파라미터레코드갯수가 1개
--group function은 파라미터레코드갯수가 n개
--공통점: 리턴값은 1개이다.
select avg(salary), max(salary), min(salary), sum(salary)
from employees; --그룹함수들은 null값을 무시한다.

--날짜도 가능.
select min(hire_date), max(hire_date) --max는 가장 최근. min은 옛날.
from employees;
--마지막 방문일, 비밀번호 변경한지 90일 지났습니다. 휴면계정
--single function에서는 sysdate, nvl function 가장많이씀.
--group function에서는 count

-- 과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

select count(*) --그룹안에 레코드 갯수가 107개 있다고 알려줌.
from employees; -- *은 모든칼럼을 뜻한다.

--과제] 70번 부서원이 몇명인지 조회하라.
select count(*)
from employees
where department_id = 70;

-- 파라미터로 *이랑 칼럼네임썼을때 차이점
select count(employee_id)
from employees;
select count(manager_id) -- 106이나옴 : null값이 있기때문.
from employees; -- *을 쓸땐 null도 빼지않고 다 포함시킬때.
-- 프라이머리키는 null값을 포함. 따라서 *이 primary key.

select avg(commission_pct)
from employees;   --영업직의 평균율. null값이 있기때문.

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct,0))
from employees;
---------------------------------------------------------------

select avg(salary)
from employees;

select avg(distinct salary) --distinct는 중복제거를 한다.
from employees; --5000이 2개면 1개만 가지고 함.

select avg(all salary) --all은 전부다 가지고함.
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;  --중복된 부서개수를 없어주니까 distinct를 쓴다.

--과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees; --이 조직에는 매니저가 18명있다를 파악가능
------------------------------------------------------------------

--원래 count는 null을 무시해주는데
--12번의 null은 group by로 인해 생긴 그룹임.
select department_id, count(employee_id) --카운트의 리턴값을 썼음.
from employees
group by department_id   --부서번호가 같은애들끼리 그룹을 만들거다.
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id 
order by department_id; --에러가남
--그룹바이에 등록한칼럼이 셀렉트에 들어갈수 있다.
--일반칼럼의 목적: 레이블(제목) job_id는 레이블의 역할을 못한다.
--select에는 groupby에 나온칼럼이랑 group function을 쓸수있다.

-- 과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id
order by job_id;
-- order by 2 도 가능.
--별명 지어서 order by 별명 도 가능.
--------------------------------------------------

select department_id, max(salary)
from employees
group by department_id  --그룹을 골라낼때는 having을 씀.
having department_id > 50;

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000;  --별명은 불가능

select department_id, max(salary)
from employees
where department_id > 50  --레코드를 먼저 골라내고 그룹을 만들었음.
group by department_id;

select department_id, max(salary) max_sal
from employees
where max_sal > 10000
group by department_id; --에러. 따라서 그룹이면 having을 써야함.
--조건문에 그룹펑션있으면 having을 쓴다.
--having은 그룹을 골라내는거


select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

--과제] 매니저ID, 매니저별 관리 직원들 중 최소월급을 조회하라.
--     최소월급이 $6,000 초과여야 한다.

select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;

------------------------------------------------

--그룹바이쓰니까 n개의 그룹. avg가 n개 실행되서 리턴값이 하나의 그룹으로 되서
--max는 1개의 리턴값받음
select max(avg(salary))
from employees
group by department_id;

select sum(max(avg(salary)))
from employees
group by department_id; --error, to deeply(너무깊이 들어갔음)
--중첩이 3차 이상되니까 못받아들임, 위의 예제와 같이 2개까지만 중첩가능.

select department_id, round(avg(salary)) --round는 12번 실행되고 12번 리턴.
from employees
group by department_id;

select department_id, round(avg(salary))
from employees; --error, 2개의 칼럼을 셀렉트할땐 그룹바이가 필요함.

------
------현장에서 많이쓰는코드.
------
-- 과제] 2001년, 2002년, 2003년도별 입사자 수를 찾는다.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

-- 과제] 직업별, 부서별 월급합을 조회하라.
--      부서는 20, 50, 80 이다.
select job_id, department_id, sum(salary)
from employees
where department_id = 20 or
    department_id = 50 or
    department_id = 80 
group by department_id, job_id
order by 2;
--강사님 답.
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;

