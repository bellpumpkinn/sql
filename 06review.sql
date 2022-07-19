--6�� join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

--equi join(�������ο� natural join�� �ִ�.)
select department_id, department_name, location_id, city
from departments natural join locations;
--join : ���ڵ带 ���ս�Ű�°��� ���Ѵ�.

-- natural join: �������̺��� �����Į���� ã�´�.
-- ����� Į���� �ʵ尪�� �����͵��� join��Ų��.
-- location������ location_id�� �����̸Ӹ�Ű(pk)
-- departmens���� �����̼�id�� ���� �̶�� �Ѵ�.
-- ����(�ܺο��� �����°�).���� ������ �ɸ��Ѱſ��� ������ �����̸Ӹ�Ű(pk), ������ ����Ű(fk)
--���̺��赵 ���̴� ���� ����(����Į���� �巯�������ʾƼ�) �׷��� �߾Ⱦ���.

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

--using
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id); --department_id�� ���ؼ� join �ߴ�.

-- ����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments;
----------------------------------------------------------

select locations.city, departments.department_name
from locations join departments
using(location_id)  --location_id�� ���ļ� �̰ɷ� ������ �ߴ�.
where location_id = 1400;

--���λ�
select l.city, d.department_name
from locations l join departments d
using(location_id)
where location_id = 1400;   --���̺��� ������ ���ϼ� �ִ�.

select l.city, d.department_name
from locations l join departments d
using(location_id)
where d.location_id = 1400; --error. using���� Į���� ���λ縦 �ٿ���.
--using���� Į���� ���λ縦 ������ ���Ѵ�.

select l.city, d.department_name, d.location_id
from locations l join departments d
using(location_id)
where location_id = 1400; --error. using�� �÷����� ���λ縦 ������ ���Ѵ�.
-- using���� Į���� ���λ縦 ������ ���Ѵ�.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100; --error.
--employees�� departments�Ѵ� manager_id�� ������ �־
--manager_id�� ���� Į������  �ָ��ؼ� ������ ����.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where e.manager_id = 100; --���λ縦 �ٿ��ִ� �۵��� �ߵȴ�.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100; --���λ縦 ������ �ʴ°� usingĮ��
--using�� �ƴ� ����Į������ ���λ縦 �ٿ����Ѵ�.
---------------------------------------------------------

--on�ȿ��ٰ� ���ǹ�
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

--����] �� ������, using���� refactoring �϶�.
select employee_id, city, department_name
from employees e join departments d
using(department_id)
join locations l
using(location_id);

--using���� where�� �Ἥ ������
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id  --on�� where ������ 2��.
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id  --on������ ���� �����ڸ� �����ְڴ�.
where e.manager_id = 149; --�����Ÿ� �̷��� �����丵 ����.

-- ����] Toronto �� ��ġ�� �μ����� ���ϴ� �������
--      �̸�, ����, �μ���ȣ, �μ���, ���ø� ��ȸ�϶�.
select e.last_name, e.job_id, e.department_id, 
        d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

--non-equi join
--���α׷��Ӹ�ŭ ���� �޴�ģ���� �˾ƺ���.
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
--------------------------------------------------------
--self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; --error. �Į������ �𸣰ڴٴ� ����.

select last_name emp, last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error.
--self join�� �ϸ� ���λ簡 �ʼ���.

-- ����] ���� �μ����� ���ϴ� ������� �̸�, �μ���ȣ, ������ �̸��� ��ȸ�϶�.
select worker.last_name worker, worker.department_id, coworker.last_name coworker
from employees worker join employees coworker
on worker.department_id = coworker.department_id
and worker.employee_id <> coworker.employee_id
order by 2, 1, 3;

-- ����] Davies ���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date
order by 2;

--����] �Ŵ������� ���� �Ի��� ������� �̸�, �Ի���, �Ŵ�����, �Ŵ����Ի����� ��ȸ�϶�.
select w.last_name, w.hire_date, m.last_name, m.hire_date
from employees w join employees m
on w.manager_id = m.employee_id --��Ŀ�� �Ŵ�����ȣ�� �Ŵ����� ������ȣ�� ������
and w.hire_date < m.hire_date;
--------------------------------���±��� �� join�� inner join�̶�� �Ѵ�.
--outer join

select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id; --grant�ϳ��� �������µ� �پ���.

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id; ----department���� ���ξȵȰ� ����.

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id; --���ʴ� ���̰� ������  full outer join���.

-- ����] ������� �̸�, ���, �Ŵ�����, �Ŵ����� ����� ��ȸ�϶�.
--      king ���嵵 ���̺� �����Ѵ�.
select w.last_name, w.employee_id, m.last_name, m.manager_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;
------------------------------------------------ 6���� 1�� ��.
-- 2��

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where d.location_id = l.location_id
and d.department_id = e.department_id; --d���̺��� �߽ɿ� �ΰ� e�� l�� ����

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;  --right outer���ǹ�
--���ʿ� (+)�� �ϸ� right outer ���ǹ�
--�����ʿ� (+)�� �ϸ� left outer ���ǹ�.
--full outer join�� ����.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--self join
 select worker.last_name || ' works for ' || manager.last_name
 from employees worker, employees manager
 where worker.manager_id = manager.employee_id;

