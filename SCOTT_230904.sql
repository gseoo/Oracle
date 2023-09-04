-- [ ����Ŭ �ڷ��� ( Data Type ) ] --
-- 1) CHAR
    - ���� ����
    - CHAR( size BYTE | CHAR)
    CHAR == CHAR(1) == CHAR(1 BYTE)
    - 2000����Ʈ
    - �ѱ�(3����Ʈ) ���ĺ�(1����Ʈ)
    
-- 2) NCHAR == N(UNICODE) + CHAR
    - NCHAR(size == ����)
    - 1����, 2000bytes
    - ���� ����
    ��) NCHAR(20)  [A][��][][][][][][][][]
    - NCHAR == NCHAR(1) 1����
    - ����Ʈ ��� ����
    
    
    -- ���̺� �̹� ����
    create table test (
                    aa char(3)  -- char(3 byte)
                    , bb char(3 char)
                    , cc nchar(3)
                    );
                    --test ���̺� ������ ����
                    
INSERT INTO test ( aa, bb, cc ) VALUES ('ȫ�浿','ȫ�浿','ȫ�浿'); -- ����
INSERT INTO test ( aa, bb, cc ) VALUES ('ȫ','ȫ�浿','ȫ�浿');
COMMIT;
            --TEST ���̺� ����
            
-- �������� : CHAR, NCHAR
-- ��������
-- 3) VARCHAR2
    -- ��������
    -- 4000byte
��) ��������/��������
    name CHAR(10 CHAR)      [m][b][c][][][][][][][����] --�������� ä����
    name VARCHAR2(10 CHAR)  [m][b][c] -- �ִ� �̸� ���ڿ��� ���̷� SIZE ����
    VARCHER2(10) == VARCHAR2(10 BYTE)
    VARCHAR2 == VARCHAR2(1) == VHARCHAR2(1 BYTE)

-- TEST ���̺� ����
-- 4) CHAR, NCAHR, VARCHAR2, [ NVARCHAR2 ]
    -- N + VARCHAR2
    -- 4000bytes
    
-- 5) LONG - ���� �ڷ���
    -- �ִ밪 : 2GB
-- JAVA : long ���� �ڷ��� - 900�� ~ 900��

-- 6) NUMBER        ���� = ���� + �Ǽ�
--    NUMBER
--    NUMBER ( p )      precision ��Ȯ�� == ��ü �ڸ���     1~38
--    NUMBER ( p , s )  scale �Ը� == �Ҽ��� ���� �ڸ���    -83 ~ 127
    NUMBER(4) -- ����
    NUMBER(5,2) -- �Ǽ�     �Ҽ��� 2�ڸ�����
    �� ) NUMBER(3,7)   0.0000[][][]
      kor NUMBER; == kor number(38, 127) ���� ū �ڷ���
      kor NUMBER(3) == kor NUMBER(3,0)
      
    �� ) 
CREATE TABLE tbl_number(
    kor NUMBER(3,0)     -- 90.89 -> 91
    , eng NUMBER(3,0)   -- -999 ~ 999
    , mat NUMBER(3,0)
    , tot NUMBER(3,0)
    , avg NUMBER(5,2)
);
-- SQL ����: ORA-00947: not enough values
INSERT INTO tbl_number (kor, eng, mat, tot, avg ) VALUES ( 90.89, 85, 100 );
-- ���������� 90.89 �ݿø����� 91�� ����
INSERT INTO tbl_number (kor, eng, mat ) VALUES ( 90.89, 85, 100 );
-- -999 ~ 999 ���� ���� ������.
INSERT INTO tbl_number (kor, eng, mat ) VALUES ( 90, 85, 300 );
INSERT INTO tbl_number (kor, eng, mat ) VALUES ( 90, 85, -999 );

INSERT INTO tbl_number (kor, eng, mat ) VALUES ( 80, 75, 30 );
COMMIT;
ROLLBACK;
--
SELECT *
FROM tbl_number;

-- [PL/SQL] for / while �ݺ��� k,e,m ������ 0~100 ����
INSERT INTO tbl_number ( kor, eng, mat ) VALUES (
        TRUNC (dbms_random.value(0, 101))
        , TRUNC (dbms_random.value(0, 101))
        , TRUNC (dbms_random.value(0, 101)) );
        -- ������ ����

SELECT TRUNC (dbms_random.value(0, 101))
FROM dual;


-- ��� �л��� ����, ��� ��� ( UPDATE )
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
number(p,s) = �Ǽ�

DESC emp;
DESC dept;

-- 7) FLOAT(p) = NUMBER

-- 8) TIMESTAMP = ��¥ + �ð�(��) 7byte + ms, ns
��) �л������� �����ϰ� �����ϴ� ���̺� ����
    �й� : NUMBER(7), CHAR -> ��������, �ѱ� X
    �̸� : NVARCHAR2(10) -> ��������, �ѱ�
            �÷� ũ�� ����
    ��, ��, ��, �� : NUMBER(3) -999 ~ 999 + üũ��������(0~100 ����)
    ��� : NUMBER(5,2) 100.00
    ��� : NUMBER(3)
    ���� : DATE
    �ֹε�Ϲ�ȣ : CHAR(14)
    
-- 9) TIMESTAMP
TIMESTAMP = TIMESTAMP(6)
TIMESTAMP(0~9)

-- 10) 2�� ������(0,1) RAW(SIZE) 2000byte, LONG RAW 2GB
��) �̹��� ����, ���� ���� -> 2�� �����ͷ� ��ȯ -> DB�� ����

-- 11) RAW(2000byte)
       LONG RAW(2GB)
       BLOB(4GB) Binary Large OBject
       BFILE
       
-- 12) CHAR, NCHAR(2000byte)
       VARCHAR2, NVARCHAR2(4000byte)
       --LONG(2GB)
       CLOB(4GB)
       NCLOB(4GB)
       


-- COUNT() OVER(ORDER BY ���ؿ�) : ������ ���� ������ ������� ��ȯ�ϴ� �Լ�
SELECT buseo, name, basicpay
     , COUNT(*) OVER(ORDER BY basicpay ASC)
     , COUNT(*) OVER(PARTITION BY buseo ORDER BY basicpay ASC)
FROM insa;


SELECT buseo, name, basicpay
     --, SUM(basicpay) OVER(ORDER BY basicpay ASC)
     , SUM(basicpay) OVER(PARTITION BY buseo ORDER BY basicpay ASC)
FROM insa;

-- �� ������ �޿� ��հ� ���� �޿����� ����
SELECT city, name, basicpay
     , AVG(basicpay) OVER(PARTITION BY city ORDER BY city)
     , basicpay - AVG(basicpay) OVER(PARTITION BY city ORDER BY city)
FROM insa;

----------------------------------------------------------------------------------------

-- ���̺� ����, ����, ����
-- ���̺� ���ڵ� �߰�, ����, ����

-- 1) ���̺� : ������ �����
-- 2) DB �𵨸� -> ���̺� ����
��) �Խ��ǿ� �Խñ��� ������ ���̺� ����
    1) ���̺�� : tbl_board
    2)              �÷���      �ڷ���       ũ��               �� ���        ����
        �۹�ȣ(����)  seq       ����(����)   NUMBER(38)          NOT NULL      �Խñ��� �ۼ��� ����
        �ۼ���       writer     ����        VARCHAR2(20)        NOT NULL
        ��й�ȣ     passwd     ����        VARCHAR2(15)        NOT NULL
        ����        title       ����        VARCHAR2(100)       NOT NULL
        ����        content     ����        CLOB               
        �ۼ���      regdate     ��¥        DATE                DEFAULT SYSDATE
    3) �Խñ��� ������ �� �ִ� ������ Ű : �۹�ȣ
    4) �ʼ� �Է� ���� : NOT NULL(NN) ��������
    5) �ۼ����� ���� �ý����� ��¥�� �ڵ� �Է�

CREATE [GLOBAL TEMPORARY] TABLE [schema.] table
      ( 
        ���̸�  ������Ÿ�� [DEFAULT ǥ����] [��������] 
       [,���̸�  ������Ÿ�� [DEFAULT ǥ����] [��������] ] 
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
-- Table TBL_BOARD��(��) �����Ǿ����ϴ�.

DESC tbl_board;

--�̸�      ��?       ����            
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
INSERT INTO tbl_board(seq, writer, passwd, title, content) -- �ۼ����� ����Ʈ���̶� ���� ����
VALUES              (2, 'hong', '1234', 'test-2', 'test-2');
INSERT INTO tbl_board VALUES(3, 'gs99', '1234', 'test-3', 'test-3', SYSDATE); -- ���̺� Į�� ������� VALUES �ۼ�
COMMIT;

-- tbl_board ���̺��� �������� ��� Ȯ��(��ȸ)
SELECT *
FROM user_constraints
WHERE table_name LIKE UPPER('%board%');


-- ��ȸ�� ���� Į�� X -> ���̺� ���� �� �߰� (���̺� ����)
-- �÷� �߰��� ���̺��� ���� �����Ѵٸ�
-- ���� �߰��Ǵ� �÷��� �̹� �����ϴ� ��� ���� ���� NULL�� �ʱ�ȭ
-- DEFAULT���� �������ָ� �ش� ������ ���� �൵ �ʱ�ȭ��
-- readed NUMBER 
-- alter table ... add �÷� �Ǵ� ��������         : ���ο� �÷��� ���̺� �߰�
-- alter table ... modify �÷�                  : �÷��� ���̺��� ����
-- alter table ... drop[constraint] ��������     : ���������� ���̺��� ����
-- alter table ... drop column �÷�             : �÷��� ���̺��� ����

ALTER TABLE tbl_board
ADD readed NUMBER DEFAULT 0;
-- Table TBL_BOARD��(��) ����Ǿ����ϴ�.


-- 1) �Խñ� �ۼ�(INSERT��) content X, readed 0, regdate SYSDATE
INSERT INTO tbl_board(writer, seq, title, passwd)
VALUES('seo', (SELECT MAX(seq)+1 FROM tbl_board), 'test-4', '1234');

-- 2) content�� null�� ��� -> '�ù�' �Խñ� ����
UPDATE tbl_board
SET content = '�ù�'
WHERE content IS NULL;
COMMIT;

select * from tbl_board;

-- 3) seo �ۼ����� ��� �Խñ� ����
DELETE FROM tbl_board
WHERE writer = 'seo';
COMMIT;

-- 4) �÷��� �ڷ����� ũ�� ����
-- WRITER NOT NULL VARCHAR2(20) -> 40
ALTER TABLE tbl_board
MODIFY(writer VARCHAR2(40));

DESC tbl_board;

-- 5) title �÷��� ���� : subject��
ALTER TABLE tbl_board
RENAME COLUMN title TO subject;

select * from tbl_board;

-- 6) bigo �÷� �߰� (��Ÿ���� �����ϴ�)
ALTER TABLE tbl_board
ADD bigo VARCHAR2(100);

-- bigo �÷� ����
ALTER TABLE tbl_board
DROP COLUMN bigo;

DROP TABLE tbl_board;

-- 7) ���̺�� ����
RENAME ���̺��1 TO ���̺��2;

----------------------------------------------------------------------------------

-- 2. ���������� �̿��ؼ� ���̺��� �����ϴ� ���
-- �̹� ������ ���̺��� ���� + ���ڵ� ������ ��� ���������� �̿��� ���̺� ����
-- ���̺� ���� + ������ ���� + �������� ���� X(NOT NULL ����)

CREATE TABLE tbl_emp (empno, ename, job, hiredate, mgr, pay, deptno)
AS 
(
    SELECT empno, ename, job, hiredate, mgr, sal + NVL(comm, 0) pay, deptno
    FROM emp
);
-- Table TBL_EMP��(��) �����Ǿ����ϴ�.

DESC tbl_emp;
SELECT * FROM tbl_emp;

-- ���������� ���� X (Ȯ���ϱ�)
SELECT *
FROM user_constraints
WHERE table_name = 'TBL_EMP';

DROP TABLE tbl_emp;


-- ���������� �̿��ؼ� ���̺� ���� + ������ ���� X
-- ���̺��� ������ �����ؼ� ������
-- WHERE ������ �������� ���� �����ϱ�
CREATE TABLE tbl_emp
AS
SELECT *
FROM emp
WHERE 1 = 0;

DESC tbl_emp;
SELECT * FROM tbl_emp;


-- [����] deptno, dnmae, empno, enmae, hiredate, pay, grade ���� ���̺� ����
CREATE TABLE tbl_empgrade
AS
(
    SELECT d.deptno, dname, empno, ename, hiredate, sal + NVL(comm, 0) pay, grade
    FROM dept d, emp e, salgrade s
    WHERE d.deptno = e.deptno AND e.sal BETWEEN losal AND hisal
);

select * from tbl_empgrade;

------------------------------------------------------------------------------

-- [ INSERT�� ]
INSERT INTO ���̺�� [(�÷���...)] VALUES (�÷���...);
COMMIT; ROLLBACK;
-- Multi + table insert��
1) unconditional insert all
   : ���ǰ� ������� ����Ǿ��� ���� ���� ���̺� �����͸� �Է�

? ���������κ��� �ѹ��� �ϳ��� ���� ��ȯ�޾� ���� insert ���� �����Ѵ�.
? into ���� values ���� ����� �÷��� ������ ������ Ÿ���� �����ؾ� �Ѵ�.

�����ġ�
	INSERT ALL | FIRST
	  [INTO ���̺�1 VALUES (�÷�1,�÷�2,...)]
	  [INTO ���̺�2 VALUES (�÷�1,�÷�2,...)]
	  .......
	Subquery;

���⼭ 
 ALL : ���������� ��� ������ �ش��ϴ� insert ���� ��� �Է�
 FIRST : ���������� ��� ������ �ش��ϴ� ù ��° insert ���� �Է�
 subquery : �Է� ������ ������ �����ϱ� ���� ���������� �� ���� �ϳ��� ���� ��ȯ�Ͽ� �� insert �� ����

-- ��)
CREATE TABLE dept_10 AS (SELECT * FROM dept WHERE 1 = 0);
CREATE TABLE dept_20 AS (SELECT * FROM dept WHERE 1 = 0);
CREATE TABLE dept_30 AS (SELECT * FROM dept WHERE 1 = 0);
CREATE TABLE dept_40 AS (SELECT * FROM dept WHERE 1 = 0);
    
INSERT ALL -- ���ǿ� ������� �������� ����� insert���� ��� �Է�
    INTO dept_10 VALUES(deptno, dname, loc)
    INTO dept_20 VALUES(deptno, dname, loc)
    INTO dept_30 VALUES(deptno, dname, loc)
    INTO dept_40 VALUES(deptno, dname, loc)
SELECT deptno, dname, loc FROM dept;
-- 16�� �� ��(��) ���ԵǾ����ϴ�.
ROLLBACK;
DROP TABLE dept_10;
DROP TABLE dept_20;
DROP TABLE dept_30;
DROP TABLE dept_40;
    
    
2) conditional insert all
emp_10, emp_20, emp_30, emp_40 ���̺� ���� ��
emp�� select ��ȸ�ϴ� ������������ �� �μ����� 4���� ������ ���̺� insert

CREATE TABLE emp_10 AS (SELECT * FROM emp WHERE 1 = 0);
CREATE TABLE emp_20 AS (SELECT * FROM emp WHERE 1 = 0);
CREATE TABLE emp_30 AS (SELECT * FROM emp WHERE 1 = 0);
CREATE TABLE emp_40 AS (SELECT * FROM emp WHERE 1 = 0);

-- ������ �ִ� �������̺� insert��
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
-- 12�� �� ��(��) ���ԵǾ����ϴ�.
SELECT * FROM emp_10;
SELECT * FROM emp_20;
SELECT * FROM emp_30;
SELECT * FROM emp_40;

ROLLBACK;

-- INSERT ALL / INSERT FIRST ������
-- INSERT ALL : �����ϴ� ��� ������ INSERT��Ŵ
-- INSERT FIRST : ó������ �����ϴ� �������� INSERT
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
-- INSERT ALL : 13�� �� ��(��) ���ԵǾ����ϴ�.
-- INSERT FIRST : 12�� �� ��(��) ���ԵǾ����ϴ�.

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

-- 1) emp_10 ���̺��� ��� ���ڵ� ���� + COMMIT, ROLLBACK
DELETE FROM emp_10;
SELECT * FROM emp_10;

-- 2) emp_20 ���̺��� ��� ���ڵ� ���� + �ڵ� Ŀ��
TRUNCATE TABLE emp_20;
SELECT * FROM emp_20;

-- 3) ���̺� ��ü�� ����
DROP TABLE emp_30;

--------------------------------------------------------------------------------

-- [����] insa ���̺��� num, name �÷��� �����ؼ� ���ο� tbl_score ���̺� ����
-- (num <= 1005)
CREATE TABLE tbl_score AS (SELECT num, name FROM insa WHERE num <= 1005);


-- [����] tbl_score ���̺� kor, eng, mat, tot, avg, grade, rank �÷� �߰�
-- (���� : ��, ��, ��, ������ �⺻�� 0)
-- grade ��� char(1 char)
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


-- [����] 1001 ~ 1005 5�� �л��� kor, eng, mat ������ ������ ������ �����ϴ� ���� �ۼ�                                 
UPDATE tbl_score
SET kor = TRUNC(dbms_random.value(0, 101)),
    eng = TRUNC(dbms_random.value(0, 101)),
    mat = TRUNC(dbms_random.value(0, 101))
;


-- [����] 1005 �л��� k, e, m -> 1001 �л��� ������ ����
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


-- [����] ��� �л��� ����, ����� ����
-- ���� : ����� �Ҽ��� 2�ڸ�
UPDATE tbl_score
SET tot = kor + eng + mat, avg = (kor + eng + mat)/3;

COMMIT;
SELECT * FROM tbl_score;

SELECT t.*, TO_CHAR(t.avg, '999.00')
FROM tbl_score t;


-- [����] ���(grade) CHAR(1 CHAR) 'A', 'B', 'C', 'D', 'F'
-- 90 �̻� A
-- 80 �̻� B
-- 70 �̻� C
-- 60 �̻� D
-- 0~59 F
UPDATE tbl_score
SET grade = 
CASE WHEN avg >= 90 THEN 'A'
     WHEN avg >= 80 THEN 'B'
     WHEN avg >= 70 THEN 'C'
     WHEN avg >= 60 THEN 'D'
     ELSE 'F'
END;
    

-- [����] tbl_score ���̺��� ��� ó�� (UPDATE)
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


-- [����] ��� �л����� ���� ������ 20�� ����
UPDATE tbl_score
SET eng =
CASE WHEN eng >= 80 THEN 100
     ELSE eng + 20
END;

COMMIT;
SELECT * FROM tbl_score;


-- [����] ��, ��, �� ������ �����Ǹ� ������ �л��� ����, ���, ���, ��ü ����� �޶���
-- PL/SQL 5������ �� ���� : Ʈ����(Trigger)


-- [����] ���л��鸸 ���� ������ 5���� ������Ű�� ���� 
-- tbl_score ���̺��� ���� Į�� x
-- insa ���̺� ���� ssn �ֹε�Ϲ�ȣ -> ���̺� ����
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

[MERGE ��]

create table tbl_emp(
    id number primary key, 
    name varchar2(10) not null,
    salary  number,
    bonus number default 100
);
-- Table TBL_EMP��(��) �����Ǿ����ϴ�.

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
-- Table TBL_BONUS��(��) �����Ǿ����ϴ�.

insert into tbl_bonus(id)
    (select e.id from tbl_emp e);
COMMIT;

SELECT * FROM tbl_bonus;

INSERT INTO tbl_bonus VALUES(1004, 50);
COMMIT;
-- bonus���� 1004�� ����� ����

-- ����(merge) tbl_emp�� tbl_bonus �� ���̺� ����
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