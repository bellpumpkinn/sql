--3�� single function
--function�� ���� �Ķ������ ������ �̱��̴�.

desc dual   -- ������ ��ȸ.
select * from dual;  -- �����͸� ��ȸ.  ���ڵ忡 �ʵ尡 1��.

select lower('SQL Course')   --�ҹ��ڷ� �ٲ���
from dual;

select upper('SQL Course')   --�빮�ڷ� �ٲ���
from dual;

select initcap('SQL Course') -- initcap: �������� ù���ڸ� �빮�ڷ� �ٲ���.
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';  --lower���� �����Ѱ�
--lower�� 107�� ����.(���ڵ� ������ŭ)

select concat('Hello', 'World')  --�Ķ���� 2���� �ٿ��� ������ ����.
from dual;

--���ڸ� �տ������� ���� �޼ҵ�
select substr('HelloWorld', 2, 5) -- 0���� 1���� ����.
from dual;

--���ڸ� �ڿ������� ���� �޼ҵ�
select substr('Hello', -1, 1) --�ǵڰ� -1, ���ʿ��� -2, �׿����� -3
from dual;

--���ڼ��� �ľ��ϴ� �޼���
select length('Hello')
from dual;

--�ش繮�ڰ� ����ε����� �ִ��� Ȯ���ϴ� �޼���, sql�� �ε����� 1���� ����.
select instr('Hello', 'l') --ó������ �߰ߵ� l�� ���ϰ��� �������� ����.
from dual;
select instr('Hello', 'w')
from dual;

--����ĭ���� ä���� ���߰� ������ ���� �޼���
select lpad(salary, 5, '*')
from employees;
select lpad('Hi', 5, '*')
from employees;

--������ĭ ä���� ���߰� ������ ���� �޼���
select rpad(salary, 5, '*')
from employees;
select rpad('Hi', 5, '*')
from employees;

--���ڸ� �ٲٰ� ������ ���� �޼���
select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello')
from dual; --trim�� �Ӹ��� �������� �Ű澲��, ���뿡�� �Ű�Ⱦ���.
select trim(' ' from ' Hello ')
from dual;

--����] �� query���� ' '�� trim ������ ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

--��ĭ����� �ٸ�����
select trim(' Hello World ') --�ڵ����� ��ĭ�� ��������.
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';
--����] �� ���忡��, where���� like �� refactoring �϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG%';

--����] �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
--      �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����Ѵ�.
select last_name, initcap(length(last_name))
from employees
where last_name like 'J%' or
        last_name like 'A%' or
        last_name like 'M%';
------------------------------------------------------------
--���ڸ� �ٷ�� function

select round(45.926, 2) -- �ݿø�
from dual;
select trunc(45.926, 2) -- ����
from dual;
select mod(1600, 300) -- ������
from dual;

select round(45.9234, 0), round(45.923)
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

--����] ������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����), �λ��(Increase)�� ��ȸ�϶�.
select last_name, salary, round(salary * 1.155) "New Salary", round(salary * 1.155) - salary "Increase"
from employees;

-----------------------------------------------------------
--��¥�� �ٷ�� �Լ�.

select sysdate  --������ �ð��� �˷���.
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
--����] 90�� �μ� ������� �̸�, �ټӳ���� ��ȸ�϶�.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual;

select add_months('2022/07/14', 1)
from dual;

--7/14 ���� �Ͽ���
select next_day('2022/07/14', 1)    --�Ͽ����� 1, ������� 7
from dual;

select last_day('2022/07/14')
from dual;

--����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�.
--      ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date) 
from employees
where months_between(sysdate, hire_date) >= 12 * 20;

--����] ������� �̸�, ���ޱ׷����� ��ȸ�϶�.
--     �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.

select last_name, rpad('*', trunc(salary / 1000), '*')
from employees;

--����] �� �׷����� ���� ���� �������� �����϶�.
select last_name, rpad('*', trunc(salary / 1000), '*')
from employees
order by salary desc;





