--3장 single function
--function에 들어가는 파라미터의 개수가 싱글이다.

desc dual   -- 구조를 조회.
select * from dual;  -- 데이터를 조회.  레코드에 필드가 1개.

select lower('SQL Course')   --소문자로 바꿔줌
from dual;

select upper('SQL Course')   --대문자로 바꿔줌
from dual;

select initcap('SQL Course') -- initcap: 각글자의 첫글자를 대문자로 바꿔줌.
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';  --lower에서 리턴한값
--lower가 107번 실행.(레코드 갯수만큼)

select concat('Hello', 'World')  --파라미터 2개를 붙여서 리턴을 해줌.
from dual;

--글자를 앞에서부터 뜯어내는 메소드
select substr('HelloWorld', 2, 5) -- 0말고 1부터 시작.
from dual;

--글자를 뒤에서부터 뜯어내는 메소드
select substr('Hello', -1, 1) --맨뒤가 -1, 왼쪽옆이 -2, 그왼쪽이 -3
from dual;

--글자수를 파악하는 메서드
select length('Hello')
from dual;

--해당문자가 몇번인덱스에 있는지 확인하는 메서드, sql은 인덱스가 1부터 시작.
select instr('Hello', 'l') --처음으로 발견된 l의 리턴값을 내보내고 끝냄.
from dual;
select instr('Hello', 'w')
from dual;

--왼쪽칸부터 채워서 맞추고 싶을때 쓰는 메서드
select lpad(salary, 5, '*')
from employees;
select lpad('Hi', 5, '*')
from employees;

--오른쪽칸 채워서 맞추고 싶을때 쓰는 메서드
select rpad(salary, 5, '*')
from employees;
select rpad('Hi', 5, '*')
from employees;

--글자를 바꾸고 싶을때 쓰는 메서드
select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello')
from dual; --trim은 머리랑 꼬리에만 신경쓰고, 몸통에는 신경안쓴다.
select trim(' ' from ' Hello ')
from dual;

--과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

--빈칸지우는 다른형태
select trim(' Hello World ') --자동으로 빈칸을 삭제해줌.
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';
--과제] 위 문장에서, where절을 like 로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG%';

--과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--      이름은 첫글자는 대문자, 나머지는 소문자로 출력한다.
select last_name, initcap(length(last_name))
from employees
where last_name like 'J%' or
        last_name like 'A%' or
        last_name like 'M%';
------------------------------------------------------------
--숫자를 다루는 function

select round(45.926, 2) -- 반올림
from dual;
select trunc(45.926, 2) -- 내림
from dual;
select mod(1600, 300) -- 나머지
from dual;

select round(45.9234, 0), round(45.923)
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

--과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.
select last_name, salary, round(salary * 1.155) "New Salary", round(salary * 1.155) - salary "Increase"
from employees;

-----------------------------------------------------------
--날짜를 다루는 함수.

select sysdate  --서버의 시각을 알려줌.
from dual;

select sysdate + 1
from dual;
select sysdate - 1 
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;
--과제] 90번 부서 사원들의 이름, 근속년수를 조회하라.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual;

select add_months('2022/07/14', 1)
from dual;

--7/14 이후 일요일
select next_day('2022/07/14', 1)    --일요일이 1, 토요일이 7
from dual;

select last_day('2022/07/14')
from dual;

--과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--      월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date) 
from employees
where months_between(sysdate, hire_date) >= 12 * 20;

--과제] 사원들의 이름, 월급그래프를 조회하라.
--     그래프는 $1000 당 * 하나를 표시한다.

select last_name, rpad('*', trunc(salary / 1000), '*')
from employees;

--과제] 위 그래프를 월급 기준 내림차순 정렬하라.
select last_name, rpad('*', trunc(salary / 1000), '*')
from employees
order by salary desc;





