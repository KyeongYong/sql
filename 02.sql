-- where 조건문

select employee_id, last_name, department_id
from employees
where department_id = 90; -- 조건문

-- 과제] 176번 사원의 이름과 부서번호를 조회하라.
select employee_id, last_name, department_id
from employees
where employee_id = '176'; -- primary key 에는 = 연산자가 온다

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; -- 데이터 타입이 같아야 연산자가 사용된다.

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06'; -- 날짜를 long type으로 저장한다

select last_name, salary
from employees
where salary <= 3000;

-- 과제] $12,000 이상 버는 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where salary >= 12000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';

select last_name, salary
from employees
where salary between 2500 and 3500; -- between ~이상 ~이하

select last_name
from employees
where last_name between 'King' and 'Smith';

-- 과제] 'King'사원의 first name, last name, 직업, 월급을 조회하라.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King'; -- 시트에 적는 데이터는 대소문자를 구별한다('king, King') sql이 구별하지 않는 것이다

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';
-------------------------------------------------------------------------------------
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); -- 100, 101, 201번 상사의 부하가 누구인지

select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;
-------------------------------------------------------------------------------------   
select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas'); -- 문자는 '' 작은 따옴표

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');
-------------------------------------------------------------------------------------
select last_name
from employees
where last_name like 'S%'; -- s: 공통점, %: wildcard, 임의의 0개 이상의 글자이다(정해진 글자수가 없다)

select last_name
from employees
where lastt_name like '%r'; -- like는 문자와 사용

-- 과제] 이름에 s가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%S%';

-- 과제] 2005년에 입사한 사원들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where hire_date like '2005%';

select last_name
from employees
where last_name like 'K___'; -- _ : 언더스코어, 글자수 정할 때의 wildcard

-- 과제] 이름의 두번째 글자가 o인 사원의 이름을 조회하라.
select last_name
from employees
where last_name like '_o%'; -- like는 검색할 때 사용된다

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; -- escape 문자를 쓰면 일반 문자로 인식된다

select last_name, job_id
from employees
where job_id like 'IT{_%' escape '{';

-- 과제] 직업에 _R이 포함된 사원들의 이름, 직업을 조회하라.
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';
-------------------------------------------------------------------------------------
select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null;

select last_name, manager_id
from employees
where manager_id is null; -- 수식에 null 값이 하나라도 있으면 전부 null이 된다(||연산자 제외) > is null 연산자 사용
-------------------------------------------------------------------------------------
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';
-------------------------------------------------------------------------------------
select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP'); -- not으로 여집합을 구할 수 있다, not은 다른 연산자와 같이 사용해야만 사용할 수 있다(기생)

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name,  job_id
from employees
where job_id not like '%IT%';

select last_name, job_id
from employees
where commission_pct is not null;

select last_name, salary
from employees
where manager_id is null and salary >= 20000;

select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

-- 과제] 월급이 $5000 이상 $12000 이하이다, 그리고
--       20번이나 50번 부서에 일하는 사원들의 이름, 월급, 부서번호를 조회하라.
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and
    department_id in(20,50);
    
-- 과제] 이름에 a와 e가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%a%' and 
    last_name like '%e%';
    
-- 과제] 직업이 영업이다. 그리고, 월급이 $2500, %3500가 아니다.
--      위 사원들의 이름, 직업, 월급을 조회하라.    
select last_name, job_id, salary
from employees
where job_id like 'SA%' and
    salary not in(2500,3500);
-----------------------------------------------    

select last_name, department_id
from employees
order by department_id; -- 오름차순 정렬

select last_name, department_id
from employees
order by department_id desc; -- 내림차순 정렬

select last_name, department_id
from employees
order by 2 desc; -- 인덱스를 사용한 내림차순 정렬

select last_name, department_id dept_id
from employees
order by dept_id desc; -- 별명을 사용한 내림차순 정렬

select last_name
from employees
where department_id = 100
order by hire_date; -- 테이블에 없는 칼럼으로도 정렬 가능하다.

select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc; 
-- 부서번호순으로 오름차순, 월급순으로 내림차순 정렬 (다중정렬)




