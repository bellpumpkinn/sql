--4��. single function ������Ÿ�Ժ�ȯ(datatype conversion)

--�ڵ� ����ȯ.
select hire_date
from employees
where hire_date = '2003/06/17'; -- ���ڸ� �ڵ����� ��¥�� ��ȯ.

select salary
from employees
where salary = '7000'; -- ���ڸ� ���ڷ� �ڵ���ȯ.

select hire_date || ''  -- �ڵ����� ��¥�� ���ڷ� ��ȯ.
from employees;

select salary || ''
from employees;  -- �ڵ����� ���ڸ� ���ڷ� ��ȯ.
----------------------------------------------------------
--��¥�� ���ڷ� �ٲ��ֱ�.
--                           ������ ���̶��ؼ� fm�̶��Ѵ�.
select to_char(sysdate, 'yyyy-mm-dd')
from dual; --��¥�� ���ڷ� �ٲ���, �׸��� ���ĵ� �ٲ���.

select to_char(hire_date)
from employees;

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;
select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;  --��ҹ��� ���� �ٲٱ� ����.

select to_char(sysdate, 'd')
from dual;  --��¥�� �ε����� �˼��ְ�����

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;
--����] �� ���̺��� �����Ϻ��� �Ի��ϼ� ������������ �����϶�.
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
from employees;  --fillmode(fm) : �����̽��� �ٿ��ش�.

--����] ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--      �λ������� �Ի��� �� 3���� �� ù��° �������̴�.
--      ��¥�� YYYY.MM.DD �� ǥ���Ѵ�.
select last_name, hire_date, 
    to_char(next_day(add_months(hire_date, 3), 2), 'YYYY.MM.DD')
    review_date
from employees;
select last_name, hire_date, 
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD')
    review_date
from employees;
------------------------------------------------------------
--���ڸ� ���ڷ� �ٲ��ֱ�

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
from dual; --fm�� ������ ������

select to_char(1237, 'L9999')
from dual;  --�ѱ� [��]���� ���� ������ L�� ���̸� �ȴ�.

--����] <�̸�> earns <$,����> monthly but wants <$,����X3>.�� ��ȸ�϶�.
select last_name ||' earns ' || to_char(salary, 'fm$99,999')
    || ' monthly but wants ' || to_char(salary * 3, 'fm$99,999') || '.'
from employees;

----------------------------------------------------------
--���ڸ� ��¥�� �ٲٴ°�

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yy');

--���� �˾Ƽ� ó���� ����µ�, �Ʒ�ó�� fx�� ���� ����(����)�� ��Ȯ�� ��ġ�ؾ��Ѵ�.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon dd, yy');

--------------------------------------------------
--���ڸ� ���ڷ�: to_number

select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; -- error parsing (�ؼ��� ���ϰ� ����.)

select to_number('1,237.12', '9,999.99')
from dual; --������ ��������� ��ȯ�� �����ϴ�.
-------------------------------------------------------
--ETC

--nvl�Լ�      
select nvl(null, 0)
from dual;  --�����Ұ��� null�̸� 0�� �����Ѵ�.

select job_id, nvl(commission_pct, 0) -- �˻��Ұ��� �⺻���� Ÿ���� ���ƾ���, ����: �ϳ���Į���� �����ϱ⶧��
from employees; --null�� ǥ���ϴ� �κ��� 0���� �ٲ�.

--����] ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, 12 * salary * (1 + nvl(commission_pct, 0)) ann_sal
from employees
order by ann_sal desc;

-- ����] ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--      Ŀ�̼��� ������, No Commission�� ǥ���Ѵ�
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees; --null�� �ƴϸ� SAL+COMM, null�̸� SAL�� ����
--nvl2(x, y, z) ù��° x�� null�� �ƴϸ� 2��° y, null�̸� 3��° z�� ����.
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name, nullif(length(first_name), length(last_name))
from employees;
--nullif: �� �Ķ������ ���� ������ null, �ٸ��� ù��° �Ķ���Ͱ��� ����.

select to_char(null), to_number(null), to_date(null)
from dual;  --null���� ������ null���� ����.

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;
--ó������ null�� �ƴѰ��� ������ None(�̺κ��� �ٸ����ڰ� ����Ҽ�����)�� �����ϰ� ����.

-- ����] ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--      Ŀ�̼��� ������, No Commission�� ǥ���Ѵ�
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

--------------------------------------------------
-- decode = switch�� ����ϴ�
-- 1��° �Ķ���� - ���ذ�, 2 �񱳰�, 3 ���ϰ�, 4 �⺻��(��������)

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

--salary�� 'a'�� ������ ����. �⺻���� �ڵ� null
select decode(salary, 'a', 1)
from employees;
--  1 ���ذ�, 2 �񱳰�, 3 ���ϰ�, 4 �⺻��
-- ��� ���ڸ� ���ڷ� �ٲ㼭 ��
select decode(salary, 'a', 1, 0)
from employees;

-- ��� job_id�� ���ڷ� �ٲ� �� ��� ����
select decode(job_id, 1, 1)
from employees; -- error, invalid number

-- ��� hire_date�� ���ڷ� �ٲٱ� �õ�
select decode(hire_date, 'a', 1)
from employees;

--��� hire_date�� ���ڷ� �ٲܼ� ��� ����
select decode(hire_date, 1, 1)
from employees;

--����] ������� ����, ������ ����� ��ȸ�϶�
--     �⺻ ����� null �̴�.
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

--���ذ��� �񱳰��� Ÿ���� ���ƾ��Ѵ�. ���ϰ��� Ÿ�Դ޶� �Ǵµ� ���ϰ������� Ÿ���� ���ƾ���.
select case job_id when '1' then 1
                   when '2' then 2
                   else 0
            end grade
from employees;

--���ذ��� �񱳰��� Ÿ���� ���ƾ��Ѵ�. ���ϰ��� Ÿ�Դ޶� �Ǵµ� ���ϰ������� Ÿ���� ���ƾ���.
--���ذ��� �񱳰��� Ÿ���� �ٸ���Ȳ -> ��������
select case salary when '1' then '1'
                   when 2 then '2'
                   else '0'
            end grade
from employees;

--���ϰ��� Ÿ���� �ٸ����غ��� ��Ȳ -> ��������
select case salary when 1 then '1'
                   when 2 then '2'
                   else 0
            end grade
from employees;

--������Ȳ.
select case salary when 1 then 1
                   when 2 then '2'
                   else '0'
            end grade
from employees;

--case�� �ƹ��� ������ ifó�� ��밡��
select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
end grade
from employees;

--����] �̸�, �Ի���, ������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
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

--����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--      2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--      ������� �̸�, �Ի���, ��ǰ�Ǳݾ��� ��ȸ�϶�.

select last_name, hire_date, 
    case when hire_date <= '2005/12/31' then '100����'
        else '10����'
    end gift
from employees
order by gift, hire_date;








