
--SQL_TEST_001 : ���̺��� �� 
select count(*) as ���̺��� from tab;

--SQL_TEST_002 : ��ü �౸�� ��� 
select TEAM_NAME as "��ü �౸�� ���" 
from TEAM
order by team_name desc
;

SELECT DISTINCT position AS "������" 
FROM plyer;
--�ߺ�����, �������� �������� ����
--nvl2()

--SQL_TEST_003 : ������ ����(�ߺ�����,������ �����) 
SELECT DISTINCT NVL2(position,position,'����') AS "������" 
FROM plyer;

-- SQL_TEST_004 : ������(ID: K02)��Ű��

--from -> where -> select -> order ��
SELECT player_name
"�̸�"
FROM player
WHERE team_id ='K02'
    AND position = 'GK'
ORDER BY player_name
    ;


--SQL_TEST_005 : ������(ID: K02) && Ű�� 170 �̻� ���� && ���� ����
--substr()
SELECT position ������, player_name �̸�
FROM player
WHERE team_id like 'K02'
    AND height >= '170'
    AND SUBSTR(player_name,1,1) like '��'
ORDER BY player_name
;
    --�ڿ� �����϶� = ��ſ� like�� ����
  
    --SUBSTR(player_name,���۹�°, ���ڼ�)



SELECT position ������, player_name �̸�
FROM player
WHERE team_id like 'K02'
    AND height >= '170'
    AND player_name like '��%'  --�ڰ˻��� ��� %�ڡ�
ORDER BY player_name
;


SELECT position ������, player_name �̸�
FROM player
WHERE team_id like 'K02'
    AND height >= '170'
    AND player_name like '��__'
ORDER BY player_name
;

--SCCOER_SQL_006 
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������

SELECT player_name ||'����' �̸�,
    NVL2(height,height,0) || 'cm' Ű,
    NVL2(height,height,0)|| 'kg' ����   
FROM player
WHERE team_id like 'K02'
ORDER BY height DESC
;


--SOCCER_SQL_007 
-- SQL_TEST_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
--BMI = ������ / Ű�� �μ�, ���⼭ �����Դ� kg, Ű�� m �����̴�. 
--���� ���ڸ�, ������ 55kg�� Ű 1.68m�� ����� BMI�� 55kg/(1.68m)^2 = 19.4�̴�

SELECT 
player_name ||'����' �̸�, 
    NVL2(height,height,0) || 'cm' Ű,
    NVL2(weight,weight,0)|| 'kg' ����,
    ROUND(weight/((height/100)*(height/100)),2) BMI
FROM player
WHERE team_id like 'K02'
ORDER BY height DESC
;

-- SOCCER_SQL_008 
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
--GK �������� ����
-- ����, ����� ��������
--SELECT team_name, position, player_name
--FROM team t, player p
--WHERE p.team_id like t.team_id
--    AND p.team_id IN('K02','K10')
--    AND p.position like 'GK'
--ORDER BY team_name, player_name
--;

SELECT t.team_name, p.position, p.player_name
FROM player p
    INNER JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.team_id IN('K02','K10')
    AND p.position like 'GK'
ORDER BY t.team_name, p.player_name
;
--���������� �ٲٱ�
SELECT t.team_name, p.position, p.player_name
FROM player p
    INNER JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.team_id IN((SELECT T.TEAM_NAME
    FROM TEAM T
    WHERE T.TEAM_NAME 
    IN ('�Ｚ��������','��Ƽ��')))
    AND p.position like 'GK'
ORDER BY t.team_name, p.player_name
;




--SOCCER_SQL_009 
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������
--SELECT height || 'cm' Ű , team_name ����, player_name �̸�
--FROM player p,team t
--WHERE height BETWEEN 180 AND 183
--    AND p.TEAM_ID like t.team_id
--    AND p.team_id IN('K02','K10')
--ORDER BY height, team_name, player_name
--;

SELECT p.height || 'cm' Ű , t.team_name ����, p.player_name �̸�
FROM player p
    INNER JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.height BETWEEN 180 AND 183
    AND p.team_id IN('K02','K10')
ORDER BY p.height, t.team_name, p.player_name
;

--���������� �ٲٱ�
SELECT p.height || 'cm' Ű , t.team_name ����, p.player_name �̸�
FROM player p
    INNER JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.height BETWEEN 180 AND 183
    AND p.team_id IN((SELECT T.TEAM_NAME
    FROM TEAM T
    WHERE T.TEAM_NAME 
    IN ('�Ｚ��������','��Ƽ��')))
ORDER BY p.height, t.team_name, p.player_name
;









-- SOCCER_SQL_010
--  ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������

SELECT t.team_name �� , p.player_name �̸�
FROM player p
    JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.position IS NULL
ORDER BY t.team_name, p.player_name
;

-- SOCCER_SQL_011
--  ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���
SELECT t.team_name ����, s.stadium_name ��Ÿ���
FROM team t
JOIN stadium s
ON t.stadium_id LIKE s.stadium_id
ORDER BY team_name
;

-- SOCCER_SQL_012
--  ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�.


SELECT 
    t.team_name ���̸�, 
    s.stadium_name ��Ÿ���, 
    sc.awayteam_id ������ID, 
    sc.sche_date �����ٳ�¥
FROM team t
    JOIN stadium s 
    ON t.stadium_id LIKE s.stadium_id
    JOIN schedule sc
    ON s.stadium_id LIKE sc.stadium_id
WHERE sc.sche_date LIKE '20120317'
ORDER BY t.team_name
;

-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

SELECT p.player_name ����,
    p.position ������,
    t.region_name ||' '|| t.team_name ����,
    s.stadium_name ��Ÿ���,
    sc.sche_date ��⳯¥
FROM player p
    JOIN team t
    ON p.team_id LIKE t.team_id
    JOIN stadium s
    ON  t.stadium_id LIKE s.stadium_id
    JOIN schedule sc
    ON s.stadium_id LIKE sc.stadium_id
WHERE p.team_id LIKE 'K03'
    AND p.position LIKE 'GK'
    AND sc.sche_date LIKE '20120317'
ORDER BY p.player_name
;

-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�


SELECT s.stadium_name ��Ÿ���,
    sc.sche_date ��⳯¥,
    t1.region_name || ' ' || t1.team_name Ȩ��,
    t2.region_name || ' ' || t2.team_name ������,
    sc.home_score "Ȩ�� ����",
    sc.away_score "������ ����"
FROM team t1
    JOIN stadium s
        ON t1.stadium_id LIKE s.stadium_id
    JOIN schedule sc
        ON s.stadium_id LIKE sc.stadium_id
    JOIN stadium sta
        ON sta.hometeam_id LIKE sc.awayteam_id
    JOIN team t2
        ON t2.stadium_id LIKE sta.stadium_id
WHERE sc.home_score - sc.away_score >= 3
ORDER BY sc.sche_date
;



select st.stadium_name ��Ÿ���,
    sc.sche_date ��⳯¥,
    t1.region_name || ' ' || t1.team_name Ȩ��,
    t2.region_name || ' ' || t2.team_name ������,
    home_score "Ȩ�� ����" ,
    away_score "������ ����"
from team t1
    join stadium st
        on t1.stadium_id like st.stadium_id
    join schedule sc
        on st.stadium_id like sc.stadium_id
    join team t2
        on t2.team_id like sc.awayteam_id
where sc.home_score - sc.away_score >= 3
order by sc.sche_date
;

--������
SELECT s.stadium_name ��Ÿ���,
    sc.sche_date ��⳯¥,
    t1.region_name || ' ' || t1.team_name Ȩ��,
    t2.region_name || ' ' || t2.team_name ������,
    sc.home_score "Ȩ�� ����",
    sc.away_score "������ ����"
from schedule sc
    join stadium s
        on sc.stadium_id like s.stadium_id
    join team t1
        on s.hometeam_id like t1.team_id
    join team t2
        on sc.awayteam_id like t2.team_id   
where sc.home_score - sc.away_score >= 3
order by sc.sche_date
;

--SOCCER_SQL_015 
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20 , �ϻ� �ؿ� ����, �Ⱦ絵 ����

SELECT s.stadium_name,
s.stadium_id,
s.seat_count,
s.hometeam_id,
t.e_team_name
FROM stadium s
    LEFT JOIN team t
    ON s.STADIUM_ID = t.STADIUM_ID
ORDER BY s.hometeam_id, s.stadium_id
;

-- SOCCER_SQL_016
-- �Ҽ��� �Ｚ�������� ���� �������
-- �巡�������� �������� ���� ����

SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ( 
        (SELECT T.TEAM_ID
        FROM TEAM T
        WHERE T.TEAM_NAME 
        IN('�巡����','�Ｚ��������')))
;



-- 018
-- ��ȣ�� ������ �Ҽ����� ������, ��ѹ��� �����Դϱ�

SELECT PLAYER_NAME ������, (SELECT T.TEAM_NAME 
FROM TEAM T, PLAYER P
WHERE T.TEAM_ID LIKE P.TEAM_ID
AND P.PLAYER_NAME LIKE '��ȣ��') ����,POSITION ������ , BACK_NO ��ѹ�
FROM PLAYER
WHERE PLAYER_NAME LIKE '��ȣ��'
;


-- 019
-- ������Ƽ���� MF ���Ű�� ���Դϱ�

SELECT ROUND(AVG(HEIGHT),2) ���Ű
FROM PLAYER
WHERE TEAM_ID LIKE 'K10'
AND POSITION LIKE 'MF'
;


-- 020
-- 2012�� ���� ������ ���Ͻÿ�

SELECT 
    (SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201201%') "1��",
    (SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201202%') "2��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201203%') "3��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201204%') "4��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201205%') "5��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201206%') "6��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201207%') "7��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201208%') "8��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201209%') "9��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201210%') "10��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201211%') "11��",(SELECT COUNT(*)
    FROM SCHEDULE SC1
    WHERE SC1.SCHE_DATE LIKE '201212%') "12��"
FROM DUAL
;



SELECT COUNT(*) "1��"
FROM SCHEDULE SC1
WHERE SC1.SCHE_DATE LIKE '201201%'
;






