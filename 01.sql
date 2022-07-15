-- select

select * from departments; -- select: 조회

select department_id, location_id
from departments; -- 가독성을 위해 두줄로, department_id, location_id 두가지의 데이터만(칼럼, 필드) 요청

select location_id, department_id
from departments;

desc departments -- sqlplus 명령어, ; 없음

-- 과제] employees 구조를 확인하라.
desc employees
-------------------------------------------------------------------------------------
select last_name, salary, salary + 300
from employees;

-- 과제] 사원들의 월급, 연봉을 조회하라.
select salary, salary * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;
------------------------------------------------------------------------------------
select last_name, job_id, commission_pct
from employees;

select last_name, job_id, 12 * salary + (12 * salary * commission_pct) -- 수식에 null 값이 하나라도 있으면 전부 null이 된다 > 버그 
from employees;
-------------------------------------------------------------------------------------
select last_name as name, commission_pct comm -- as 생략가능, 별명으로 쓸 수 있다
from employees;

select last_name "Name", salary * 12 "Annual Salary" -- 대소문자 구별 ""
from employees;

-- 과제] 사원들의 사번, 이름, 직업, 입사일(STARTDATE)을 조회하라.
select employee_id, last_name, job_id, hire_date STARTDATE
from employees;

-- 과제] 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;
-------------------------------------------------------------------------------------
-- 수식이 포함된 
select last_name || job_id -- table 붙이기 연산자 ||
from employees;

select last_name || ' is ' || job_id -- 중간에 상수 삽입, 가독성이 생긴다
from employees;

select last_name || ' is ' || job_id employee -- 별명 붙이기
from employees;

select last_name || null -- 연산자는 타입이 같아야한다, null을 문자로 바꾼다
from employees;

select last_name || commission_pct -- commission_pct가 문자로 바뀐다
from employees;

select last_name || salary
from employees;

select last_name || hire_date
from employees;

select last_name || (salary * 12) -- 붙이기 연산자의 데이터 타입은 전부 문자이다.
from employees;

-- 과제] 사원들의 '이름, 직업'(Emp & Title)을 조회하라.
select last_name ||', ' || job_id "Emp and Title"
from employees;