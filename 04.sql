-- datatype conversion 데이터 타입 변환

select hire_date
from employees
where hire_date = '2003/06/17'; -- 문자가 자동으로 날짜로 변환.

select salary
from employees
where salary = '7000'; -- 문자가 자동으로 숫자로 변환.

select hire_date || ''
from employees; -- 날짜가 문자로 변환.

select salary || ''
from employees; -- 숫자가 문자로 변환.
-----------------------------------------
select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd')
from dual; -- 날짜를 문자 형식으로 변환.

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)') --DAY 는 FRIDAY, (DY) 는 FRI 로 출력된다.
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)') -- 대,소문자 구별. 
from dual;

select to_char(sysdate, 'd') -- 'd' 는 요일인덱스.
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;
-- 과제] 위 테이블을 월요일부터 오름차순 정렬하라.
select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd') asc;

select to_char(sysdate, 'hh24:mi:ss am')
from dual; -- 시: 분: 초 오전/오후

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month RR') -- fill mode
from employees; -- 스페이스를 최소화 시킨다. 쓸데없는 여백들을 삭제.

-- 과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한 지 3개월 후 첫번째 월요일이다.
--      날짜는 YYYY.MM.DD 로 표시한다.
select last_name, to_char(hire_date, 'YYYY.MM.DD'),
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;
-----------------------------------------

select to_char(salary)
from employees;

select to_char(salary,  '$99,999.99'),
    to_char(salary,  '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
    '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237, 'L9999')
from dual; -- 원 단위로 사용하고 싶을땐 , L 을 붙히면된다.

--과제] <이름> earns <$,월급> monthly but wants <$,월급x3>. 로 조회하라.
select last_name || ' earns ' ||
    to_char(salary, 'fm$99,999') || ' montly but wants ' ||
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;
-----------------------------------------

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy'); 
-- Format eX -error : 정확하게 처리 해야한다.
------------------------------------------

select to_number('1237')
from dual; -- 숫자로 변환.

select to_number('1,237.12')
from dual; -- error

select to_number('1,237.12', '9,999.99')
from dual;
------------------------------------------

-- null
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0) -- nvl 의 데이터타입은 같아야한다. 하나의 칼럼을 구성하기 때문이다.
from employees;

-- 과제] 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

-- 과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면, No Commission 을 출력한다.
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name, 
    nullif(length(first_name), length(last_name))
from employees; -- null 을 리턴하거나 두개의 파라미터가 다르면, 첫번째 파라미터를 리턴한다.

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees; -- 처음으로 리턴 하는 값을 null.
------------------------------------------

select last_name, salary, 
    decode(trunc(salary / 2000), -- 기준값
        0, 0.00, -- 비교값, 리턴값
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
            0.45) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1) -- 기본값이 null 로 리턴된다.
from employees;

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees; -- error, invalid number

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees; -- error

-- 과제] 사원들의 직업, 직업별 등급을 조회하라.
--      IT_PROG     A
--      AD_PRES     B
--      ST_MAN      C
--      ST_CLERK    D
select job_id, decode(job_id,
    'IT_PROG', 'A',
    'AD_PRES', 'B',
    'ST_MAN',  'C',
    'ST_CLERK','D') grade
from employees;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                    when '2' then 2
                    else 0
        end grade
from employees;

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees; -- error 

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0
        end grade
from employees; -- error

select case salary when 1 then 1
                    when 2 then '2'
                    else '0'
        end grade
from employees; -- error

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medidum'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

-- 과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.
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

-- 과제] 2005년 이전에 입사한 사원들에겐 100만원 상품권,
--      2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.
select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100만원'
        else '10만원' end gift
from employees
order by gift, hire_date;
