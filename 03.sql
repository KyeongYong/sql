-- single function(파라미터가 1개인 경우)

desc dual -- 가짜 table(DUMMY)
select * from dual; -- record가 return된 것이다

select lower('SQL Course') -- parameter로 field 값 하나(SQL Course) 있는 record를 받아서 소문자로 return해준다
from dual; -- 소문자로 바꿔준다

select upper('SQL Course') -- 소문자를 대문자로 바꿔준다
from dual;

select initcap('SQL course')-- 첫글자를 대문자로 바꿔준다
from dual;

select last_name
from employees
where last_name = 'higgins'; -- 대문자와 다른 데이터이다

select last_name
from employees
where last_name = 'Higgins'; -- 소문자와 다른 데이터이다

select last_name
from employees
where lower(last_name) = 'higgins';
-- last_name function에는 대문자가 있지만(레코드가 파라미터로 들어간다-레코드 갯수만큼 실행된다)
-- lower때문에 'higgins'와 같다고 나온다

select concat('Hello', 'World')
from dual;

select substr('HelloWorld', 2, 5) --(idx위치-SQL은 1부터 시작, length)
from dual;
select substr('Hello', -1, 1)
from dual;
-- 2번째 글자부터 5개를 뜯어낸다

select length('Hello')
from dual;
-- 글자수 확인하는 메소드

select instr('Hello', 'l')
from dual;
-- 문자가 있는지 확인하는 메소드
-- 0보다 크면 문자가 있고, 0이면 문자가 없다
select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*') 
from employees; -- salary를 써서 칼럼명을 써준다
-- 5자리중에 왼쪽에 *을 넣겠다
select rpad(salary, 5, '*')
from employees;
-- 5자리중에 오른쪽에 *을 넣겠다

-- 과제] 사원들의 이름, 월급그래프를 조회하라.
--      그래프는 $1000 당 * 하나를 표시한다.
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

--과제] 위 그래프를 월급 기준 내림차순 정렬하라.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;
-- J자리에 BL을 넣겠다
select trim('H' from 'Hello')
from dual;
-- 첫글자와 마지막 글자만 뜯어낼 수 있다
select trim('l' from 'Hello')
from dual;
select trim(' ' from ' Hello ')
from dual;
-- 과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제] 아래 문장에서, where 절을 like 로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자 수를 조회하라.
--      이름의 첫글자는 대문자, 나머지는 소문자로 출력한다.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
--------------------------------------

select round(45.926, 2)
from dual; -- 반올림 처리된다.
select trunc(45.926, 2)
from dual;  -- 내림 처리된다.

select round(45.923, 0), round(45.923)
from dual; -- 정수값을 구해준다.
select trunc(45.923, 0), round(45.923)
from dual; -- 정수값을 구해주지만, 내림처리 된다.

-- 과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.
select last_name, salary, 
    round(salary * 1.155) "New Salary",
    round(salary * 1.155) - salary "Increase"
from employees;
---------------------------------------

select sysdate
from dual; -- 서버의 시각을 호출해준다.

select sysdate + 1
from dual; -- plusdays
select sysdate - 1
from dual; -- minusdays

select sysdate - sysdate
from dual; -- sysdate + sysdate 는 없다.

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- 과제] 90번 부서 사원들의 이름, 근속년수를 조회하라.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual; -- 개월수 차이를 구해준다.

select add_months('2022/07/14', 1)
from dual; -- +월 이다.

select next_day('2022/07/14', 5)
from dual; -- 일요일: 1 ~ 토요일 : 7 (일, 월, 화, 수, 목, 금, 토)

select next_day('2022/07/14', 'thursday')
from dual;

select next_day('2022/07/14', 'thu')
from dual;

select last_day('2022/07/14')
from dual; -- 월의 말일을 조회한다.

-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--      월급을 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;
