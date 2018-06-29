
--SQL_TEST_001 : 테이블의 수 
select count(*) as 테이블수 from tab;

--SQL_TEST_002 : 전체 축구팀 목록 
select TEAM_NAME as "전체 축구팀 목록" 
from TEAM
order by team_name desc
;

SELECT DISTINCT position AS "포지션" 
FROM plyer;
--중복제거, 값없으면 신입으로 기재
--nvl2()

--SQL_TEST_003 : 포지션 종류(중복제거,없으면 빈공간) 
SELECT DISTINCT NVL2(position,position,'신입') AS "포지션" 
FROM plyer;

-- SQL_TEST_004 : 수원팀(ID: K02)골키퍼

--from -> where -> select -> order 순
SELECT player_name
"이름"
FROM player
WHERE team_id ='K02'
    AND position = 'GK'
ORDER BY player_name
    ;


--SQL_TEST_005 : 수원팀(ID: K02) && 키가 170 이상 선수 && 성이 고씨
--substr()
SELECT position 포지선, player_name 이름
FROM player
WHERE team_id like 'K02'
    AND height >= '170'
    AND SUBSTR(player_name,1,1) like '고'
ORDER BY player_name
;
    --뒤에 문자일때 = 대신에 like로 쓰기
  
    --SUBSTR(player_name,시작번째, 글자수)

SELECT position 포지션, player_name 이름
FROM player
WHERE team_id like 'K02'
    AND height >= '170'
    AND player_name like '고%'  --★검색시 사용 %★★
ORDER BY player_name
;


SELECT position 포지선, player_name 이름
FROM player
WHERE team_id like 'K02'
    AND height >= '170'
    AND player_name like '고__'
ORDER BY player_name
;

--SCCOER_SQL_006 
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순

SELECT player_name ||'선수' 이름,
    NVL2(height,height,0) || 'cm' 키,
    NVL2(height,height,0)|| 'kg' 무게   
FROM player
WHERE team_id like 'K02'
ORDER BY height DESC
;


--SOCCER_SQL_007 
-- SQL_TEST_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순
--BMI = 몸무게 / 키² 로서, 여기서 몸무게는 kg, 키는 m 단위이다. 
--예를 들자면, 몸무게 55kg에 키 1.68m인 사람의 BMI는 55kg/(1.68m)^2 = 19.4이다

SELECT 
player_name ||'선수' 이름, 
    NVL2(height,height,0) || 'cm' 키,
    NVL2(weight,weight,0)|| 'kg' 무게,
    ROUND(weight/((height/100)*(height/100)),2) BMI
FROM player
WHERE team_id like 'K02'
ORDER BY height DESC
;

-- SOCCER_SQL_008 
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
--GK 포지션인 선수
-- 팀명, 사람명 오름차순
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
--서브쿼리로 바꾸기
SELECT t.team_name, p.position, p.player_name
FROM player p
    INNER JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.team_id IN((SELECT T.TEAM_NAME
    FROM TEAM T
    WHERE T.TEAM_NAME 
    IN ('삼성블루윙즈','시티즌')))
    AND p.position like 'GK'
ORDER BY t.team_name, p.player_name
;

--SOCCER_SQL_009 
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순
--SELECT height || 'cm' 키 , team_name 팀명, player_name 이름
--FROM player p,team t
--WHERE height BETWEEN 180 AND 183
--    AND p.TEAM_ID like t.team_id
--    AND p.team_id IN('K02','K10')
--ORDER BY height, team_name, player_name
--;

SELECT p.height || 'cm' 키 , t.team_name 팀명, p.player_name 이름
FROM player p
    INNER JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.height BETWEEN 180 AND 183
    AND p.team_id IN('K02','K10')
ORDER BY p.height, t.team_name, p.player_name
;

--서브쿼리로 바꾸기
SELECT p.height || 'cm' 키 , t.team_name 팀명, p.player_name 이름
FROM player p
    INNER JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.height BETWEEN 180 AND 183
    AND p.team_id IN((SELECT T.TEAM_NAME
    FROM TEAM T
    WHERE T.TEAM_NAME 
    IN ('삼성블루윙즈','시티즌')))
ORDER BY p.height, t.team_name, p.player_name
;


-- SOCCER_SQL_010
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

SELECT t.team_name 팀 , p.player_name 이름
FROM player p
    JOIN team t
    ON p.team_id LIKE t.team_id
WHERE p.position IS NULL
ORDER BY t.team_name, p.player_name
;

-- SOCCER_SQL_011
--  팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력
SELECT t.team_name 팀명, s.stadium_name 스타디움
FROM team t
JOIN stadium s
ON t.stadium_id LIKE s.stadium_id
ORDER BY team_name
;

-- SOCCER_SQL_012
--  팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오.


SELECT 
    t.team_name 팀이름, 
    s.stadium_name 스타디움, 
    sc.awayteam_id 원정팀ID, 
    sc.sche_date 스케줄날짜
FROM team t
    JOIN stadium s 
    ON t.stadium_id LIKE s.stadium_id
    JOIN schedule sc
    ON s.stadium_id LIKE sc.stadium_id
WHERE sc.sche_date LIKE '20120317'
ORDER BY t.team_name
;

-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

SELECT p.player_name 선수,
    p.position 포지션,
    t.region_name ||' '|| t.team_name 팀명,
    s.stadium_name 스타디움,
    sc.sche_date 경기날짜
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
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

select st.stadium_name 스타디움,
    sc.sche_date 경기날짜,
    t1.region_name || ' ' || t1.team_name 홈팀,
    t2.region_name || ' ' || t2.team_name 원정팀,
    home_score "홈팀 점수" ,
    away_score "원정팀 점수"
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

--선생님
SELECT 
    s.stadium_name 스타디움,
    sc.sche_date 경기날짜,
    t1.region_name || ' ' || t1.team_name 홈팀,
    t2.region_name || ' ' || t2.team_name 원정팀,
    sc.home_score "홈팀 점수",
    sc.away_score "원정팀 점수"
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
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20 , 일산 밑에 마산, 안양도 있음

SELECT
    s.stadium_name,
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
-- 소속이 삼성블루윙즈 팀인 선수들과
-- 드래곤즈팀인 선수들의 선수 정보

SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ( 
        (SELECT T.TEAM_ID
        FROM TEAM T
        WHERE T.TEAM_NAME 
        IN('드래곤즈','삼성블루윙즈')))
;


-- 018
-- 최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까

SELECT 
    P.PLAYER_NAME 선수명, 
    T.TEAM_NAME 팀명,
    P.POSITION 포지션 , 
    P.BACK_NO 백넘버
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE
    P.PLAYER_NAME LIKE '최호진'
;

-- 019
-- 대전시티즌의 MF 평균키는 얼마입니까

SELECT 
    ROUND(AVG(P.HEIGHT),2) 평균키
FROM 
    PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_NAME LIKE '시티즌'
AND P.POSITION LIKE 'MF'
;

-- 020
-- 2012년 월별 경기수를 구하시오
SELECT 
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201201%') "1월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201202%') "2월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201203%') "3월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201204%') "4월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201205%') "5월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201206%') "6월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201207%') "7월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201208%') "8월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201209%') "9월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201210%') "10월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201211%') "11월",
    (SELECT COUNT(*)
    FROM SCHEDULE 
    WHERE SCHE_DATE LIKE '201212%') "12월"
FROM DUAL
;

-- 021
-- 2012년 월별 진행된 경기수(GUBUN IS YES)를 구하시오
-- 출력은 1월:20경기 이런식으로...

SELECT 
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201201%'
    AND GUBUN LIKE 'Y')||'경기' "1월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201202%'
    AND GUBUN LIKE 'Y')||'경기' "2월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201203%'
    AND GUBUN LIKE 'Y')||'경기' "3월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201204%'
    AND GUBUN LIKE 'Y')||'경기' "4월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201205%'
    AND GUBUN LIKE 'Y')||'경기' "5월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201206%'
    AND GUBUN LIKE 'Y')||'경기' "6월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201207%'
    AND GUBUN LIKE 'Y')||'경기' "7월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201208%'
    AND GUBUN LIKE 'Y')||'경기' "8월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201209%'
    AND GUBUN LIKE 'Y')||'경기' "9월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201210%'
    AND GUBUN LIKE 'Y')||'경기' "10월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201211%'
    AND GUBUN LIKE 'Y')||'경기' "11월",
    (SELECT COUNT(*)
    FROM SCHEDULE
    WHERE SCHE_DATE LIKE '201212%'
    AND GUBUN LIKE 'Y')||'경기 ' "12월"
FROM DUAL
;

-- 022
-- 2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀: ?   원정팀: ? 로 출력

SELECT 
    HT.TEAM_NAME 홈팀, 
    AT.TEAM_NAME 원정팀
FROM SCHEDULE S
    JOIN STADIUM STA
        ON S.STADIUM_ID LIKE STA.STADIUM_ID
    JOIN TEAM HT
        ON S.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
        ON S.AWAYTEAM_ID LIKE AT.TEAM_ID
WHERE 
    SCHE_DATE LIKE '20120914'
;


--023
-- GRUOP BY  사용
-- 팀별 선수의 수 EX. 아이파크 20명

SELECT 
    T.TEAM_NAME 팀명,
    COUNT(P.PLAYER_ID)||'명' 선수인원
FROM
    TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY
    T.TEAM_NAME
ORDER BY 
    T.TEAM_NAME
;

--023 TEAM_NAME 을 쓰지 말아야하는상황
SELECT 
    (SELECT A.TEAM_NAME
    FROM TEAM A
    WHERE A.TEAM_ID LIKE T.TEAM_ID    
    ) 팀명,
    COUNT(P.PLAYER_ID)||'명' 선수인원
FROM
    TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY
    T.TEAM_ID
ORDER BY 
    T.TEAM_ID
;


--023
--팀별 골키퍼의 평균키
-- 아이파크 180CM

SELECT
    T.TEAM_NAME 팀
    ,ROUND(AVG(P.HEIGHT))||'cm' 평균키
FROM
    TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE
    P.POSITION LIKE 'GK'
GROUP BY
    T.TEAM_NAME
ORDER BY
    T.TEAM_NAME
;

--023 TEAM_ID로 GROUP BY 할것
SELECT
    (
    SELECT A.TEAM_NAME
    FROM TEAM A
    WHERE A.TEAM_ID LIKE T.TEAM_ID
    ) 팀
    ,ROUND(AVG(P.HEIGHT))||'cm' 평균키
FROM
    TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE
    P.POSITION LIKE 'GK'
GROUP BY
    T.TEAM_ID
ORDER BY
    T.TEAM_ID
;



SELECT
    PLAYER_NAME 이름,
    CASE 
        WHEN POSITION IS NULL THEN '없음'
        WHEN POSITION LIKE 'GK' THEN '골키퍼'
        WHEN POSITION LIKE 'MF' THEN '미드필더'
        WHEN POSITION LIKE 'DF' THEN '수비수'
        WHEN POSITION LIKE 'FW' THEN '공격수'        
        ELSE POSITION
    END 포지션
FROM 
    PLAYER
WHERE 
    TEAM_ID = 'K08'
;



--키 순으로 정렬하기!
--hint : 인라인 뷰 이용

--rownum 은 반드시 가상테이블(인라인뷰)에서 해서 밖에서 줘야함
SELECT 
    ROWNUM "No.",
    --A.팀명,
    --A.선수명,
    --A.포지션,
    --A.백넘버,
    --A.키
    A.*
FROM 
    (SELECT 
        T.TEAM_NAME 팀명,
        P.PLAYER_NAME 선수명,
        P.POSITION 포지션,
        P.BACK_NO 백넘버,
        P.HEIGHT 키
    FROM PLAYER P
        JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID         
    WHERE 
        T.TEAM_ID LIKE 
            (SELECT TEAM_ID
            FROM TEAM
            WHERE TEAM_NAME LIKE '삼성블루윙즈'
            )
        AND P.HEIGHT IS NOT NULL 
    ORDER BY P.HEIGHT DESC) A;

;


--025
--삼성블루윙즈에서 키순으로 탑10
--ROWNUM 

SELECT 
     ROWNUM "No.",
    --A.팀명,
    --A.선수명,
    --A.포지션,
    --A.백넘버,
    --A.키
    A.*
FROM 
    (SELECT
        T.TEAM_NAME 팀명,
        P.PLAYER_NAME 선수명,
        P.POSITION 포지션,
        P.BACK_NO 백넘버,
        P.HEIGHT 키
    FROM PLAYER P
        JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID         
    WHERE 
        T.TEAM_ID LIKE 
            (SELECT TEAM_ID
            FROM TEAM
            WHERE TEAM_NAME LIKE '삼성블루윙즈'
            )
        AND P.HEIGHT IS NOT NULL 
        
    ORDER BY P.HEIGHT DESC) A
WHERE ROWNUM <= 10
;


--025
--삼성블루윙즈에서 키순으로 11등~ 20등
SELECT 
    ROWNUM RNUM,
    B.*
FROM
(SELECT 
     ROWNUM "No.",
    --A.팀명,
    --A.선수명,
    --A.포지션,
    --A.백넘버,
    --A.키
    A.*
FROM 
    (SELECT
        T.TEAM_NAME 팀명,
        P.PLAYER_NAME 선수명,
        P.POSITION 포지션,
        P.BACK_NO 백넘버,
        P.HEIGHT 키
    FROM PLAYER P
        JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID         
    WHERE 
        T.TEAM_ID LIKE 
            (SELECT TEAM_ID
            FROM TEAM
            WHERE TEAM_NAME LIKE '삼성블루윙즈'
            )
        AND P.HEIGHT IS NOT NULL 
        
    ORDER BY P.HEIGHT DESC) A) B
WHERE RNUM BETWEEN 11 AND 20
;

-- 026
-- 팀별 골키퍼의 평균 키에서
-- 가장 평균키가 큰 팀명은

SELECT
    ROWNUM NO,
    A.SOCTEAM
FROM
(SELECT
        T.TEAM_NAME SOCTEAM
        ,ROUND(AVG(P.HEIGHT))||'cm' HEIGHT
    FROM
        TEAM T
        JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
    WHERE
        P.POSITION LIKE 'GK'
    GROUP BY
        T.TEAM_NAME
    ORDER BY
        HEIGHT DESC
) A
WHERE ROWNUM = 1
;


-- 027
-- 각 구단별 선수들 평균키가 
--삼성 블루윙즈팀의 평균키보다 작은 
--팀의 이름과 해당 팀의 평균키를 구하시오

SELECT 
    T.TEAM_NAME 팀명,
    AVG(P.HEIGHT) 평균키
FROM
    TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN 
        (SELECT 
        P.TEAM_ID AID,
        ROUND(AVG(P.HEIGHT)) AVGH
        FROM 
            PLAYER P
            JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID
        WHERE
            T.TEAM_NAME LIKE '삼성블루윙즈') A
    ON T.TEAM_ID LIKE A.AID
    JOIN
        (SELECT 
        P.TEAM_ID BID,
        ROUND(AVG(P.HEIGHT)) AVGH
        FROM 
            PLAYER P
            JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID
        WHERE
            T.TEAM_NAME NOT LIKE '삼성블루윙즈') B
    ON T.TEAM_ID LIKE B.BID 
    
WHERE
   B.AVGH <= A.AVGH
GROUP BY T.TEAM_NAME
ORDER BY ROUND(AVG(P.HEIGHT)) DESC
;

select
   (select tb.team_name
   from team tb
   where tb.team_id like t.team_id) 팀명,
   round(avg(p.height),2) 평균키 
from player p
   join team t
       on p.team_id like t.team_id
group by t.team_id
having avg(p.height)<(
       select avg(pa.height)
       from player pa
           join team ta
               on pa.team_id like ta.team_id
       where ta.team_name like '삼성블루윙즈')
;



-- 028
-- 2012년 경기 중에서 점수차가 가장 큰 경기 전부
--ABS는 오라클전용, 지양하자

SELECT
    SC.SCHE_DATE 날짜,
    HT.TEAM_NAME 홈팀,
    AT.TEAM_NAME 원정팀,
    ABS(SC.HOME_SCORE - SC.AWAY_SCORE) 점수차
FROM
    SCHEDULE SC
    JOIN STADIUM S
        ON SC.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM HT
        ON SC.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
        ON SC.AWAYTEAM_ID LIKE AT.TEAM_ID
WHERE
    SC.SCHE_DATE LIKE '2012%'
    AND (SC.HOME_SCORE - SC.AWAY_SCORE) IS NOT NULL
ORDER BY 
    ABS(SC.HOME_SCORE - SC.AWAY_SCORE) DESC
    ,SC.SCHE_DATE
;

-- 028
-- 2012년 경기 중에서 점수차가 가장 큰 경기 전부
-- 20120317, 일화천마 VS 유나이티드, 점수차
SELECT A.*
FROM(SELECT
        K.SCHE_DATE 경기날짜,
        HT.TEAM_NAME || ' VS ' || AT.TEAM_NAME 경기,
        CASE
            WHEN K.HOME_SCORE >= K.AWAY_SCORE THEN (K.HOME_SCORE - K.AWAY_SCORE)
            ELSE K.AWAY_SCORE - K.HOME_SCORE
        END 점수차
     FROM
        SCHEDULE K
        JOIN TEAM HT
            ON K.HOMETEAM_ID LIKE HT.TEAM_ID
        JOIN TEAM AT
            ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
     WHERE
        K.SCHE_DATE LIKE '2012%'
        AND K.GUBUN LIKE 'Y'
    
     ORDER BY 점수차 DESC) A
WHERE ROWNUM LIKE 1
;






-- 029
-- 좌석수대로 스타디움 순서 매기기
SELECT
    ROWNUM NO,
    A.*
FROM
    (SELECT
        S.STADIUM_NAME 스타디움,
        S.SEAT_COUNT 좌석수
    FROM
        STADIUM S
    ORDER BY S.SEAT_COUNT DESC) A
ORDER BY NO 
;

-- 030
-- 2012년 구단 승리 순으로 순위매기기
SELECT
    HT.TEAM_NAME 홈팀,
    AT.TEAM_NAME 원정팀,
    (HOME_SCORE - SC.AWAY_SCORE) HTWIN,
    (SC.AWAY_SCORE - SC.HOME_SCORE) ATWIN
FROM 
    SCHEDULE SC
    JOIN STADIUM S
        ON SC.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM HT
        ON SC.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
        ON SC.AWAYTEAM_ID LIKE AT.TEAM_ID

;



SELECT    
   A.TEAM_NAME 팀명,    
   COUNT(A.SCORE)+COUNT(B.SCORE) 승수
FROM    (SELECT    
           SC.HOME_SCORE - SC.AWAY_SCORE SCORE,
           HT.TEAM_ID TEAM_ID,
           HT.TEAM_NAME TEAM_NAME
       FROM SCHEDULE SC
           JOIN TEAM HT ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
           JOIN TEAM AT ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID
       WHERE
           SC.HOME_SCORE - SC.AWAY_SCORE >0
           AND SC.SCHE_DATE LIKE '2012%') A 
       JOIN
       (SELECT    
           SC1.AWAY_SCORE - SC1.HOME_SCORE SCORE,
           AT1.TEAM_ID TEAM_ID,
           AT1.TEAM_NAME TEAM_NAME
       FROM SCHEDULE SC1
           JOIN TEAM HT1 ON HT1.TEAM_ID LIKE SC1.HOMETEAM_ID
           JOIN TEAM AT1 ON AT1.TEAM_ID LIKE SC1.AWAYTEAM_ID
       WHERE
           SC1.AWAY_SCORE - SC1.HOME_SCORE >0
           AND SC1.SCHE_DATE LIKE '2012%') B ON A.TEAM_ID LIKE B.TEAM_ID
GROUP BY
       A.TEAM_ID,A.TEAM_NAME
ORDER BY    
       COUNT(A.SCORE) DESC
;
















