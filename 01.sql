--1�� select --�̰� �ּ���

select * from departments; --���̺��� ������. Į�������� �ܼ���
--select * from : ���Į���� ��ȸ

select department_id, location_id --���ڵ��� Ÿ�� �Ǵ� ���̺� Ÿ���� �ɼ�����.
from departments;  -- Ư�� Į���� �ް������.

select location_id, department_id
from departments;  --�� ����� Į������ ���ϱ� ����.

desc departments --departments�� ����Ȯ��.

-- ����] employees ������ Ȯ���϶�.
desc employees

select last_name, salary, salary + 300 --�ͽ�������: ���� ��Ÿ���°�
from employees;

-- ����] ������� ����, ������ ��ȸ�϶�.

select salary, salary * 12
from employees;

--�켱����.
select last_name, salary, 12 * salary + 100
from employees;
select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;
select last_name, job_id, (12 * salary)*(1 + commission_pct)
from employees; --Ŀ�̼� �ȹ޴¾ֵ��� �����ȶ�. null�� �־ �׷�.

--Į���̸��� �ٲٱ�.(����)
select last_name as name, commission_pct comm --as�� ��������
from employees;
--��ҹ��� ����ְ� ������ ""���
select last_name as "Name", 12 * salary "Annual Salary"
from employees;

-- ����] ������� ���, �̸�, ����, �Ի���(STARTDATE)�� ��ȸ�϶�.
select employee_id, last_name, job_id, hire_date startdate
from employees;

-- ����] ������� ���(Emp #), �̸�(Name), ����(Job), �Ի���(Hire Date)�� ��ȸ�϶�.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

select last_name || job_id
from employees;  --�ϳ��� Į������ ���̴¹� ||���
select last_name || ' is ' || job_id
from employees; 
select last_name || ' is ' || job_id employee
from employees; 
select last_name || null --null�� null�� �ƴ� ���� null�� �޾Ƶ���.
from employees;
select last_name || commission_pct
from employees;   --���ڰ� ���ڰ��Ǽ� ���ڷ� ����
select last_name || salary   
from employees;   --���� 24000�� �Ǽ� ����king24000�� ��.
select last_name || hire_date   
from employees;   --��¥�� ���ڰ� �Ǽ� ���ڷ� ����.
select last_name || (salary * 12)
from employees;

--����] ������� '�̸�, ����'(Emp and Title)�� ��ȸ�϶�.
select last_name || ', ' || job_id "Emp and Title"
from employees;



