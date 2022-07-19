--4장. single function 데이터타입변환(datatype conversion)

--자동 형변환.
select hire_date
from employees
where hire_date = '2003/06/17'; -- 문자를 자동으로 날짜로 변환.

select salary
from employees
where salary = '7000'; -- 문자를 숫자로 자동변환.

select hire_date || ''  -- 자동으로 날짜를 문자로 변환.
from employees;

select salary || ''
from employees;  -- 자동으로 숫자를 문자로 변환.
----------------------------------------------------------
--날짜를 문자로 바꿔주기.
--                           ↓폼의 모델이라해서 fm이라한다.
select to_char(sysdate, 'yyyy-mm-dd')
from dual; --날짜를 문자로 바꿔줌, 그리고 형식도 바꿔줌.

select to_char(hire_date)
from employees;

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;
select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;  --대소문자 형식 바꾸기 가능.

select to_char(sysdate, 'd')
from dual;  --날짜의 인덱스를 알수있게해줌

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;
--과제] 위 테이블을 월요일부터 입사일순 오름차순으로 정렬하라.
select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1 , 'd'), hire_date;
    
select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'DD Month RR')
from employees;

select to_char(hire_date, 'fmDD Month RR')
from employees;  --fillmode(fm) : 스페이스를 줄여준다.

--과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한 지 3개월 후 첫번째 월요일이다.
--      날짜는 YYYY.MM.DD 로 표시한다.
select last_name, hire_date, 
    to_char(next_day(add_months(hire_date, 3), 2), 'YYYY.MM.DD')
    review_date
from employees;
select last_name, hire_date, 
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD')
    review_date
from employees;
------------------------------------------------------------
--숫자를 문자로 바꿔주기

select to_char(salary)
from employees;

select to_char(salary, '$99,999.99'),
       to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
       '|' || to_char(12.12, '0000.000') || '|'
from dual;
select '|' || to_char(12.12, 'fm9999.999') || '|',
       '|' || to_char(12.12, 'fm0000.000') || '|'
from dual; --fm은 공백을 없애줌

select to_char(1237, 'L9999')
from dual;  --한국 [원]단위 쓰고 싶으면 L을 붙이면 된다.

--과제] <이름> earns <$,월급> monthly but wants <$,월급X3>.로 조회하라.
select last_name ||' earns ' || to_char(salary, 'fm$99,999')
    || ' monthly but wants ' || to_char(salary * 3, 'fm$99,999') || '.'
from employees;

----------------------------------------------------------
--문자를 날짜로 바꾸는거

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yy');

--위는 알아서 처리를 해줬는데, 아래처럼 fx를 쓰면 포맷(형식)이 정확히 일치해야한다.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon dd, yy');

--------------------------------------------------
--문자를 숫자로: to_number

select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; -- error parsing (해석을 못하고 있음.)

select to_number('1,237.12', '9,999.99')
from dual; --형식을 맞춰줘야지 변환이 가능하다.
-------------------------------------------------------
--ETC

--nvl함수      
select nvl(null, 0)
from dual;  --조사할값이 null이면 0을 리턴한다.

select job_id, nvl(commission_pct, 0) -- 검사할값과 기본값의 타입이 같아야함, 이유: 하나의칼럼을 구성하기때문
from employees; --null로 표현하던 부분이 0으로 바뀜.

--과제] 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, 12 * salary * (1 + nvl(commission_pct, 0)) ann_sal
from employees
order by ann_sal desc;

-- 과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면, No Commission을 표시한다
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees; --null이 아니면 SAL+COMM, null이면 SAL이 나옴
--nvl2(x, y, z) 첫번째 x가 null이 아니면 2번째 y, null이면 3번째 z가 나옴.
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name, nullif(length(first_name), length(last_name))
from employees;
--nullif: 두 파라미터의 값이 같으면 null, 다르면 첫번째 파라미터값을 리턴.

select to_char(null), to_number(null), to_date(null)
from dual;  --null값을 넣으면 null값이 들어간다.

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;
--처음으로 null이 아닌값이 나오면 None(이부분은 다른문자가 대신할수있음)을 리턴하고 나옴.

-- 과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면, No Commission을 표시한다
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

--------------------------------------------------
-- decode = switch랑 비슷하다
-- 1번째 파라미터 - 기준값, 2 비교값, 3 리턴값, 4 기본값(생략가능)

select last_name, salary,
    decode( trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
            0.45) tax_rate   --else 0.45   
from employees
where department_id = 80;

--salary가 'a'와 같을수 없음. 기본값은 자동 null
select decode(salary, 'a', 1)
from employees;
--  1 기준값, 2 비교값, 3 리턴값, 4 기본값
-- 얘는 숫자를 문자로 바꿔서 비교
select decode(salary, 'a', 1, 0)
from employees;

-- 얘는 job_id를 숫자로 바꿀 수 없어서 에러
select decode(job_id, 1, 1)
from employees; -- error, invalid number

-- 얘는 hire_date를 문자로 바꾸기 시도
select decode(hire_date, 'a', 1)
from employees;

--얘는 hire_date를 숫자로 바꿀수 없어서 에러
select decode(hire_date, 1, 1)
from employees;

--과제] 사원들의 직업, 직업별 등급을 조회하라
--     기본 등급은 null 이다.
--     IT_PROG     A
--     AD_PRES     B
--     ST_MAN      C
--     ST_CLERK    D

select job_id, decode(job_id,
    'IT_PROG', 'A',
   'AD_PRES', 'B',
    'ST_MAN', 'C',
    'ST_CLERK', 'D') grade
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;    

--기준값과 비교값은 타입이 같아야한다. 리턴값은 타입달라도 되는데 리턴값끼리는 타입이 같아야함.
select case job_id when '1' then 1
                   when '2' then 2
                   else 0
            end grade
from employees;

--기준값과 비교값은 타입이 같아야한다. 리턴값은 타입달라도 되는데 리턴값끼리는 타입이 같아야함.
--기준값과 비교값의 타입이 다른상황 -> 에러가남
select case salary when '1' then '1'
                   when 2 then '2'
                   else '0'
            end grade
from employees;

--리턴값의 타입을 다르게해보는 상황 -> 에러가남
select case salary when 1 then '1'
                   when 2 then '2'
                   else 0
            end grade
from employees;

--에러상황.
select case salary when 1 then 1
                   when 2 then '2'
                   else '0'
            end grade
from employees;

--case에 아무값 없으면 if처럼 사용가능
select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
end grade
from employees;

--과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.
select last_name, hire_date, to_char(hire_date, 'day'),
    case to_char(hire_date, 'fmday') 
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
        end day
from employees
order by day;

--과제] 2005년 이전에 입사한 사원들에겐 100만원 상품권,
--      2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.

select last_name, hire_date, 
    case when hire_date <= '2005/12/31' then '100만원'
        else '10만원'
    end gift
from employees
order by gift, hire_date;








