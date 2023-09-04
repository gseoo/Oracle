-- [ 오라클 자료형 ( Data Type ) ] --
-- 1) CHAR
    - 고정 길이
    - CHAR( size BYTE | CHAR)
    CHAR == CHAR(1) == CHAR(1 BYTE)
    - 2000바이트
    - 한글(3바이트) 알파벳(1바이트)
    
-- 2) NCHAR == N(UNICODE) + CHAR
    - NCHAR(size == 문자)
    - 1문자, 2000bytes
    - 고정 길이
    예) NCHAR(20)  [A][한][][][][][][][][]
    - NCHAR == NCHAR(1) 1문자
    - 바이트 사용 못함
    
    
    -- 테이블 이미 존재
    create table test (
                    aa char(3)  -- char(3 byte)
                    , bb char(3 char)
                    , cc nchar(3)
                    );
                    --test 테이블 삭제후 생성
                    
INSERT INTO test ( aa, bb, cc ) VALUES ('홍길동','홍길동','홍길동'); -- 오류
INSERT INTO test ( aa, bb, cc ) VALUES ('홍','홍길동','홍길동');
COMMIT;
            --TEST 테이블 삭제
            
-- 고정길이 : CHAR, NCHAR
-- 가변길이
-- 3) VARCHAR2
    -- 가변길이
    -- 4000byte
예) 고정길이/가변길이
    name CHAR(10 CHAR)      [m][b][c][][][][][][][공백] --공백으로 채워짐
    name VARCHAR2(10 CHAR)  [m][b][c] -- 최대 이름 문자열의 길이로 SIZE 설정
    VARCHER2(10) == VARCHAR2(10 BYTE)
    VARCHAR2 == VARCHAR2(1) == VHARCHAR2(1 BYTE)

-- TEST 테이블 삭제
-- 4) CHAR, NCAHR, VARCHAR2, [ NVARCHAR2 ]
    -- N + VARCHAR2
    -- 4000bytes
    
-- 5) LONG - 문자 자료형
    -- 최대값 : 2GB
-- JAVA : long 정수 자료형 - 900경 ~ 900경

-- 6) NUMBER        숫자 = 정수 + 실수
--    NUMBER
--    NUMBER ( p )      precision 정확도 == 전체 자릿수     1~38
--    NUMBER ( p , s )  scale 규모 == 소수점 이하 자리수    -83 ~ 127
    NUMBER(4) -- 정수
    NUMBER(5,2) -- 실수     소수점 2자리까지
    예 ) NUMBER(3,7)   0.0000[][][]
      kor NUMBER; == kor number(38, 127) 가장 큰 자료형
      kor NUMBER(3) == kor NUMBER(3,0)
      
    예 ) 
CREATE TABLE tbl_number(
    kor NUMBER(3,0)     -- 90.89 -> 91
    , eng NUMBER(3,0)   -- -999 ~ 999
    , mat NUMBER(3,0)
    , tot NUMBER(3,0)
    , avg NUMBER(5,2)
);
-- SQL 오류: ORA-00947: not enough values
INSERT INTO tbl_number (kor, eng, mat, tot, avg ) VALUES ( 90.89, 85, 100 );
-- 국어점수에 90.89 반올림값인 91이 생성
INSERT INTO tbl_number (kor, eng, mat ) VALUES ( 90.89, 85, 100 );
-- -999 ~ 999 까지 값이 들어가진다.
INSERT INTO tbl_number (kor, eng, mat ) VALUES ( 90, 85, 300 );
INSERT INTO tbl_number (kor, eng, mat ) VALUES ( 90, 85, -999 );

INSERT INTO tbl_number (kor, eng, mat ) VALUES ( 80, 75, 30 );
COMMIT;
ROLLBACK;
--
SELECT *
FROM tbl_number;

-- [PL/SQL] for / while 반복문 k,e,m 랜덤한 0~100 정수
INSERT INTO tbl_number ( kor, eng, mat ) VALUES (
        TRUNC (dbms_random.value(0, 101))
        , TRUNC (dbms_random.value(0, 101))
        , TRUNC (dbms_random.value(0, 101)) );
        -- 여러번 실행

SELECT TRUNC (dbms_random.value(0, 101))
FROM dual;


-- 모든 학생의 총점, 평균 계산 ( UPDATE )
UPDATE tbl_number
SET tot = kor+eng+mat , avg = ( kor+eng+mat ) / 3
;
-- WHERE
COMMIT;
  
----

SELECT *
FROM tbl_number;

UPDATE tbl_number
SET avg = 99999
WHERE avg = 92;

DROP TABLE tbl_number;

-- char, nchar      varchar2, nvarchar2
-- long
-- number(p,s)
number = number(38, 127)
number(p) = number(p,0)
number(p,s) = 실수

DESC emp;
DESC dept;

-- 7) FLOAT(p) = NUMBER

-- 8) TIMESTAMP = 날짜 + 시간(초) 7byte + ms, ns
예) 학생정보를 저장하고 관리하는 테이블 생성
    학번 : NUMBER(7), CHAR -> 고정길이, 한글 X
    이름 : NVARCHAR2(10) -> 가변길이, 한글
            컬럼 크기 수정
    국, 영, 수, 총 : NUMBER(3) -999 ~ 999 + 체크제약조건(0~100 정수)
    평균 : NUMBER(5,2) 100.00
    등수 : NUMBER(3)
    생일 : DATE
    주민등록번호 : CHAR(14)
    
-- 9) TIMESTAMP
TIMESTAMP = TIMESTAMP(6)
TIMESTAMP(0~9)

-- 10) 2진 데이터(0,1) RAW(SIZE) 2000byte, LONG RAW 2GB
예) 이미지 파일, 실행 파일 -> 2진 데이터로 변환 -> DB에 저장

-- 11) RAW(2000byte)
       LONG RAW(2GB)
       BLOB(4GB) Binary Large OBject
       BFILE
       
-- 12) CHAR, NCHAR(2000byte)
       VARCHAR2, NVARCHAR2(4000byte)
       --LONG(2GB)
       CLOB(4GB)
       NCLOB(4GB)
       


-- COUNT() OVER(ORDER BY 기준열) : 질의한 행의 누적된 결과값을 반환하는 함수
SELECT buseo, name, basicpay
     , COUNT(*) OVER(ORDER BY basicpay ASC)
     , COUNT(*) OVER(PARTITION BY buseo ORDER BY basicpay ASC)
FROM insa;


SELECT buseo, name, basicpay
     --, SUM(basicpay) OVER(ORDER BY basicpay ASC)
     , SUM(basicpay) OVER(PARTITION BY buseo ORDER BY basicpay ASC)
FROM insa;

-- 각 지역별 급여 평균과 나의 급여액의 차이
SELECT city, name, basicpay
     , AVG(basicpay) OVER(PARTITION BY city ORDER BY city)
     , basicpay - AVG(basicpay) OVER(PARTITION BY city ORDER BY city)
FROM insa;

----------------------------------------------------------------------------------------

-- 테이블 생성, 수정, 삭제
-- 테이블 레코드 추가, 수정, 삭제

-- 1) 테이블 : 데이터 저장소
-- 2) DB 모델링 -> 테이블 생성
예) 게시판에 게시글을 저장할 테이블 생성
    1) 테이블명 : tbl_board
    2)              컬럼명      자료형       크기               널 허용        설명
        글번호(열쇠)  seq       숫자(정수)   NUMBER(38)          NOT NULL      게시글이 작성된 순서
        작성자       writer     문자        VARCHAR2(20)        NOT NULL
        비밀번호     passwd     문자        VARCHAR2(15)        NOT NULL
        제목        title       문자        VARCHAR2(100)       NOT NULL
        내용        content     문자        CLOB               
        작성일      regdate     날짜        DATE                DEFAULT SYSDATE
    3) 게시글을 구분할 수 있는 고유한 키 : 글번호
    4) 필수 입력 사항 : NOT NULL(NN) 제약조건
    5) 작성일은 현재 시스템의 날짜로 자동 입력

CREATE [GLOBAL TEMPORARY] TABLE [schema.] table
      ( 
        열이름  데이터타입 [DEFAULT 표현식] [제약조건] 
       [,열이름  데이터타입 [DEFAULT 표현식] [제약조건] ] 
       [,...]  
      ); 

CREATE TABLE tbl_board
(
      seq        NUMBER(38)                      NOT NULL PRIMARY KEY
    , writer    VARCHAR2(20)                     NOT NULL
    , passwd    VARCHAR2(15)                     NOT NULL
    , title     VARCHAR2(100)                    NOT NULL
    , content   CLOB
    , regdate   DATE            DEFAULT SYSDATE
);
-- Table TBL_BOARD이(가) 생성되었습니다.

DESC tbl_board;

--이름      널?       유형            
--------- -------- ------------- 
--SEQ     NOT NULL NUMBER(38)    
--WRITER  NOT NULL VARCHAR2(20)  
--PASSWD  NOT NULL VARCHAR2(15)  
--TITLE   NOT NULL VARCHAR2(100) 
--CONTENT          CLOB          
--REGDATE          DATE   

select * from tbl_board;

INSERT INTO tbl_board(seq, writer, passwd, title, content, regdate)
VALUES              (1, 'admin', '1234', 'test-1', 'test-1', SYSDATE);
INSERT INTO tbl_board(seq, writer, passwd, title, content) -- 작성일은 디폴트값이라 삭제 가능
VALUES              (2, 'hong', '1234', 'test-2', 'test-2');
INSERT INTO tbl_board VALUES(3, 'gs99', '1234', 'test-3', 'test-3', SYSDATE); -- 테이블 칼럼 순서대로 VALUES 작성
COMMIT;

-- tbl_board 테이블의 제약조건 모두 확인(조회)
SELECT *
FROM user_constraints
WHERE table_name LIKE UPPER('%board%');


-- 조회수 관련 칼럼 X -> 테이블 생성 후 추가 (테이블 수정)
-- 컬럼 추가시 테이블의 행이 존재한다면
-- 새로 추가되는 컬럼은 이미 존재하는 모든 행의 값은 NULL로 초기화
-- DEFAULT값을 설정해주면 해당 값으로 기존 행도 초기화됨
-- readed NUMBER 
-- alter table ... add 컬럼 또는 제약조건         : 새로운 컬럼을 테이블에 추가
-- alter table ... modify 컬럼                  : 컬럼을 테이블에서 수정
-- alter table ... drop[constraint] 제약조건     : 제약조건을 테이블에서 삭제
-- alter table ... drop column 컬럼             : 컬럼을 테이블에서 삭제

ALTER TABLE tbl_board
ADD readed NUMBER DEFAULT 0;
-- Table TBL_BOARD이(가) 변경되었습니다.


-- 1) 게시글 작성(INSERT문) content X, readed 0, regdate SYSDATE
INSERT INTO tbl_board(writer, seq, title, passwd)
VALUES('seo', (SELECT MAX(seq)+1 FROM tbl_board), 'test-4', '1234');

-- 2) content가 null인 경우 -> '냉무' 게시글 수정
UPDATE tbl_board
SET content = '냉무'
WHERE content IS NULL;
COMMIT;

select * from tbl_board;

-- 3) seo 작성자의 모든 게시글 삭제
DELETE FROM tbl_board
WHERE writer = 'seo';
COMMIT;

-- 4) 컬럼의 자료형의 크기 수정
-- WRITER NOT NULL VARCHAR2(20) -> 40
ALTER TABLE tbl_board
MODIFY(writer VARCHAR2(40));

DESC tbl_board;

-- 5) title 컬럼명 수정 : subject로
ALTER TABLE tbl_board
RENAME COLUMN title TO subject;

select * from tbl_board;

-- 6) bigo 컬럼 추가 (기타사항 저장하는)
ALTER TABLE tbl_board
ADD bigo VARCHAR2(100);

-- bigo 컬럼 삭제
ALTER TABLE tbl_board
DROP COLUMN bigo;

DROP TABLE tbl_board;

-- 7) 테이블명 수정
RENAME 테이블명1 TO 테이블명2;

----------------------------------------------------------------------------------

-- 2. 서브쿼리를 이용해서 테이블을 생성하는 방법
-- 이미 기존에 테이블이 존재 + 레코드 존재할 경우 서브쿼리를 이용해 테이블 생성
-- 테이블 생성 + 데이터 복사 + 제약조건 복사 X(NOT NULL 제외)

CREATE TABLE tbl_emp (empno, ename, job, hiredate, mgr, pay, deptno)
AS 
(
    SELECT empno, ename, job, hiredate, mgr, sal + NVL(comm, 0) pay, deptno
    FROM emp
);
-- Table TBL_EMP이(가) 생성되었습니다.

DESC tbl_emp;
SELECT * FROM tbl_emp;

-- 제약조건은 복사 X (확인하기)
SELECT *
FROM user_constraints
WHERE table_name = 'TBL_EMP';

DROP TABLE tbl_emp;


-- 서브쿼리를 이용해서 테이블 생성 + 데이터 복사 X
-- 테이블의 구조만 복사해서 생성함
-- WHERE 조건을 거짓으로 만들어서 생성하기
CREATE TABLE tbl_emp
AS
SELECT *
FROM emp
WHERE 1 = 0;

DESC tbl_emp;
SELECT * FROM tbl_emp;


-- [문제] deptno, dnmae, empno, enmae, hiredate, pay, grade 가진 테이블 생성
CREATE TABLE tbl_empgrade
AS
(
    SELECT d.deptno, dname, empno, ename, hiredate, sal + NVL(comm, 0) pay, grade
    FROM dept d, emp e, salgrade s
    WHERE d.deptno = e.deptno AND e.sal BETWEEN losal AND hisal
);

select * from tbl_empgrade;

------------------------------------------------------------------------------

-- [ INSERT문 ]
INSERT INTO 테이블명 [(컬럼명...)] VALUES (컬럼값...);
COMMIT; ROLLBACK;
-- Multi + table insert문
1) unconditional insert all
   : 조건과 상관없이 기술되어진 여러 개의 테이블에 데이터를 입력

? 서브쿼리로부터 한번에 하나의 행을 반환받아 각각 insert 절을 수행한다.
? into 절과 values 절에 기술한 컬럼의 개수와 데이터 타입은 동일해야 한다.

【형식】
	INSERT ALL | FIRST
	  [INTO 테이블1 VALUES (컬럼1,컬럼2,...)]
	  [INTO 테이블2 VALUES (컬럼1,컬럼2,...)]
	  .......
	Subquery;

여기서 
 ALL : 서브쿼리의 결과 집합을 해당하는 insert 절에 모두 입력
 FIRST : 서브쿼리의 결과 집합을 해당하는 첫 번째 insert 절에 입력
 subquery : 입력 데이터 집합을 정의하기 위한 서브쿼리는 한 번에 하나의 행을 반환하여 각 insert 절 수행

-- 예)
CREATE TABLE dept_10 AS (SELECT * FROM dept WHERE 1 = 0);
CREATE TABLE dept_20 AS (SELECT * FROM dept WHERE 1 = 0);
CREATE TABLE dept_30 AS (SELECT * FROM dept WHERE 1 = 0);
CREATE TABLE dept_40 AS (SELECT * FROM dept WHERE 1 = 0);
    
INSERT ALL -- 조건에 상관없이 서브쿼리 결과를 insert절에 모두 입력
    INTO dept_10 VALUES(deptno, dname, loc)
    INTO dept_20 VALUES(deptno, dname, loc)
    INTO dept_30 VALUES(deptno, dname, loc)
    INTO dept_40 VALUES(deptno, dname, loc)
SELECT deptno, dname, loc FROM dept;
-- 16개 행 이(가) 삽입되었습니다.
ROLLBACK;
DROP TABLE dept_10;
DROP TABLE dept_20;
DROP TABLE dept_30;
DROP TABLE dept_40;
    
    
2) conditional insert all
emp_10, emp_20, emp_30, emp_40 테이블 생성 후
emp를 select 조회하는 서브쿼리에서 각 부서별로 4개의 각각의 테이블에 insert

CREATE TABLE emp_10 AS (SELECT * FROM emp WHERE 1 = 0);
CREATE TABLE emp_20 AS (SELECT * FROM emp WHERE 1 = 0);
CREATE TABLE emp_30 AS (SELECT * FROM emp WHERE 1 = 0);
CREATE TABLE emp_40 AS (SELECT * FROM emp WHERE 1 = 0);

-- 조건이 있는 다중테이블 insert문
--INSERT ALL 
3) conditional first insert
INSERT FIRST
    WHEN deptno = 10 THEN
        INTO emp_10 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    WHEN deptno = 20 THEN
        INTO emp_20 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    WHEN deptno = 30 THEN
        INTO emp_30 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    ELSE
        INTO emp_40 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT * FROM emp;
-- 12개 행 이(가) 삽입되었습니다.
SELECT * FROM emp_10;
SELECT * FROM emp_20;
SELECT * FROM emp_30;
SELECT * FROM emp_40;

ROLLBACK;

-- INSERT ALL / INSERT FIRST 차이점
-- INSERT ALL : 만족하는 모든 구문에 INSERT시킴
-- INSERT FIRST : 처음으로 만족하는 구문에만 INSERT
--INSERT ALL
INSERT FIRST
    WHEN deptno = 10 THEN
        INTO emp_10 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    WHEN job = 'CLERK' THEN
        INTO emp_20 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    ELSE
        INTO emp_40 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT * 
FROM emp;
-- INSERT ALL : 13개 행 이(가) 삽입되었습니다.
-- INSERT FIRST : 12개 행 이(가) 삽입되었습니다.

SELECT *
FROM emp
WHERE JOB = 'CLERK' AND deptno = 10;


4) pivoting insert 

create table sales(
    employee_id       number(6),
    week_id            number(2),
    sales_mon          number(8,2),
    sales_tue          number(8,2),
    sales_wed          number(8,2),
    sales_thu          number(8,2),
    sales_fri          number(8,2)
);

insert into sales values(1101,4,100,150,80,60,120);
insert into sales values(1102,5,300,300,230,120,150);
COMMIT;

create table sales_data(
    employee_id        number(6),
    week_id            number(2),
    sales              number(8,2)
);

insert all
    into sales_data values(employee_id, week_id, sales_mon)
    into sales_data values(employee_id, week_id, sales_tue)
    into sales_data values(employee_id, week_id, sales_wed)
    into sales_data values(employee_id, week_id, sales_thu)
    into sales_data values(employee_id, week_id, sales_fri)
select employee_id, week_id, sales_mon, sales_tue, sales_wed,
       sales_thu, sales_fri
from sales;

select * from sales;
select * from sales_data;

-- 1) emp_10 테이블의 모든 레코드 삭제 + COMMIT, ROLLBACK
DELETE FROM emp_10;
SELECT * FROM emp_10;

-- 2) emp_20 테이블의 모든 레코드 삭제 + 자동 커밋
TRUNCATE TABLE emp_20;
SELECT * FROM emp_20;

-- 3) 테이블 자체를 삭제
DROP TABLE emp_30;

--------------------------------------------------------------------------------

-- [문제] insa 테이블에서 num, name 컬럼만 복사해서 새로운 tbl_score 테이블 생성
-- (num <= 1005)
CREATE TABLE tbl_score AS (SELECT num, name FROM insa WHERE num <= 1005);


-- [문제] tbl_score 테이블에 kor, eng, mat, tot, avg, grade, rank 컬럼 추가
-- (조건 : 국, 영, 수, 총점은 기본값 0)
-- grade 등급 char(1 char)
ALTER TABLE tbl_score
ADD (kor NUMBER(3) DEFAULT 0
    , eng NUMBER(3) DEFAULT 0
    , mat NUMBER(3) DEFAULT 0
    , tot NUMBER(3) DEFAULT 0
    , avg NUMBER(5,2)
    , grade CHAR(1 CHAR)
    , rank NUMBER(3)
);

SELECT * FROM tbl_score;


-- [문제] 1001 ~ 1005 5명 학생의 kor, eng, mat 점수를 임의의 점수로 수정하는 쿼리 작성                                 
UPDATE tbl_score
SET kor = TRUNC(dbms_random.value(0, 101)),
    eng = TRUNC(dbms_random.value(0, 101)),
    mat = TRUNC(dbms_random.value(0, 101))
;


-- [문제] 1005 학생의 k, e, m -> 1001 학생의 점수로 수정
UPDATE tbl_score
SET kor = (SELECT kor FROM tbl_score WHERE num = 1005),
    eng = (SELECT eng FROM tbl_score WHERE num = 1005),
    mat = (SELECT mat FROM tbl_score WHERE num = 1005)
WHERE num = 1001;

UPDATE tbl_score
SET (kor, eng, mat) = (SELECT kor, eng, mat FROM tbl_score WHERE num = 1005)
WHERE num = 1001;

COMMIT;
SELECT * FROM tbl_score;


-- [문제] 모든 학생의 총점, 평균을 수정
-- 조건 : 평균은 소수점 2자리
UPDATE tbl_score
SET tot = kor + eng + mat, avg = (kor + eng + mat)/3;

COMMIT;
SELECT * FROM tbl_score;

SELECT t.*, TO_CHAR(t.avg, '999.00')
FROM tbl_score t;


-- [문제] 등급(grade) CHAR(1 CHAR) 'A', 'B', 'C', 'D', 'F'
-- 90 이상 A
-- 80 이상 B
-- 70 이상 C
-- 60 이상 D
-- 0~59 F
UPDATE tbl_score
SET grade = 
CASE WHEN avg >= 90 THEN 'A'
     WHEN avg >= 80 THEN 'B'
     WHEN avg >= 70 THEN 'C'
     WHEN avg >= 60 THEN 'D'
     ELSE 'F'
END;
    

-- [문제] tbl_score 테이블의 등수 처리 (UPDATE)
UPDATE tbl_score p
-- SET rank = (SELECT COUNT(*) + 1 FROM tbl_score WHERE p.tot < tot)
SET rank = (
            SELECT t.r
            FROM(
                SELECT num, tot, RANK() OVER(ORDER BY tot DESC) r
                FROM tbl_score 
            ) t
            WHERE t.num = p.num
);
            
COMMIT;
SELECT * FROM tbl_score;


-- [문제] 모든 학생들의 영어 점수를 20점 증가
UPDATE tbl_score
SET eng =
CASE WHEN eng >= 80 THEN 100
     ELSE eng + 20
END;

COMMIT;
SELECT * FROM tbl_score;


-- [문제] 국, 영, 수 점수가 수정되면 수정된 학생의 총점, 평균, 등급, 전체 등수도 달라짐
-- PL/SQL 5가지의 한 종류 : 트리거(Trigger)


-- [문제] 남학생들만 국어 점수를 5점씩 증가시키는 쿼리 
-- tbl_score 테이블에서 성별 칼럼 x
-- insa 테이블에 성별 ssn 주민등록번호 -> 테이블 조인
UPDATE tbl_score
SET kor =
CASE WHEN kor >= 95 THEN 100
     ELSE kor + 5
END
WHERE num = ANY (
    SELECT num
    FROM insa
    WHERE MOD(SUBSTR(ssn, -7, 1), 2) = 1
);


--------------------------------------------------------------------------------

[MERGE 문]

create table tbl_emp(
    id number primary key, 
    name varchar2(10) not null,
    salary  number,
    bonus number default 100
);
-- Table TBL_EMP이(가) 생성되었습니다.

DESC tbl_emp;

insert into tbl_emp(id,name,salary) values(1001,'jijoe',150);
insert into tbl_emp(id,name,salary) values(1002,'cho',130);
insert into tbl_emp(id,name,salary) values(1003,'kim',140);
COMMIT;

SELECT * FROM tbl_emp;

create table tbl_bonus(
    id number, 
    bonus number default 100
);
-- Table TBL_BONUS이(가) 생성되었습니다.

insert into tbl_bonus(id)
    (select e.id from tbl_emp e);
COMMIT;

SELECT * FROM tbl_bonus;

INSERT INTO tbl_bonus VALUES(1004, 50);
COMMIT;
-- bonus에만 1004번 사원이 있음

-- 병합(merge) tbl_emp와 tbl_bonus 두 테이블 병합
MERGE INTO tbl_bonus b
USING (SELECT id, salary FROM tbl_emp) e
ON (b.id = e.id)
WHEN MATCHED THEN
    UPDATE SET b.bonus = b.bonus + e.salary * 0.01
WHEN NOT MATCHED THEN 
    INSERT (b.id, b.bonus) VALUES (e.id, e.salary*0.01)
;

SELECT * FROM tbl_emp;
SELECT * FROM tbl_bonus;