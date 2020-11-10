### pivot
```sql

 DECLARE cnt NUMBER;
  BEGIN
    SELECT COUNT(*) INTO cnt FROM user_tables WHERE table_name = 'MY_TABLE';
    IF cnt <> 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE MY_TABLE';
    END IF;
  END;

  CREATE TABLE "SYSTEM"."MY_TABLE" 
   (	"ST" VARCHAR2(20 BYTE), 
	"GD" VARCHAR2(20 BYTE), 
	"SG" VARCHAR2(20 BYTE)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into SYSTEM.MY_TABLE
SET DEFINE OFF;


Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','A','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','B','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','C','s2');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','D','s3');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a2','A','s4');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a2','A','s2');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b1','B','s2');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b1','C','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b1','C','s2');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b1','A','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b1','B','s2');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b2','C','s4');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b2','E','s2');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a3','D','s3');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a3','D','s3');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b1','B','s2');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b1','C','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('b1','C','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','A','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','A','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','A','s1');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','C','s2');
Insert into SYSTEM.MY_TABLE (ST,GD,SG) values ('a1','B','s1');

with x1 as ( 

SELECT GD,ST, s1,s2,s3,s4 from MY_TABLE 
pivot (count(SG) for SG in ( 's1' as s1, 's2' as s2 , 's3' as s3 , 's4' as s4))
order by GD,ST 

)

SELECT 'ALL' as item_name, sum(S1) as s1,sum(S2) s2 ,sum(S3) s3,sum(S4) s4, sum(S1)+sum(S2)+sum(S3)+sum(S4) as total   from x1 UNION
SELECT 'AB' as item_name, sum(S1) as s1,sum(S2) s2 ,sum(S3) s3,sum(S4) s4, sum(S1)+sum(S2)+sum(S3)+sum(S4) as total   from x1  WHERE GD IN ('A','B')

```



### sum top
```sql
select * from TEST_table ;

WITH x1  AS (
    SELECT  cu,team, RANK() over(partition by cu,team order by stage_order ) as  rn  , price 
    FROM TEST_table 
) , x2 as

( select cu,team, max(rn) as index_S0 , max(rn)-5  as index_S4  from x1
  group by cu,team
)

select x1.cu,x1.team,sum(x1.price) 
from x1,x2
where x1.cu = x2.cu and x1.team = x2.team 
and  x1.rn > x2.index_S4
group by x1.cu, x1.team

```


### multiple with

```sql

WITH x1  AS (
    SELECT * FROM T1
) , 
x2 as
(
SELECT * FROM 
    (
        SELECT P,L, M, count(M) over(partition by P,L) as count_
        FROM 
        ( SELECT DISTINCT P,L,M
          FROM T1 WHERE P IN ( SELECT P FROM x1 )
      
        )
        ORDER BY 4,1,2
    )
) , x3 as (
        SELECT P,L, M, sum( NVL(RC, 0)) over(partition by P,L,M) as sum_
        FROM T1 WHERE P IN ( SELECT P FROM x1 )
)
SELECT distinct x1.P,x1.L, x1.M,x2.count_ , x3.sum_
FROM x1,x2,x3
WHERE   x1.M = x2.M
AND     x1.M = x3.M
order by 1 desc ,2 desc , 3 

```


### Remove duplicate

```sql
select rowid as rid, book_name, 
row_number() over(partition by book_name  order by book_name ) rn from books ; 


select book_name from ( 
select rowid as rid, book_name, 
row_number() over(partition by book_name  order by book_name ) rn from books 
) where rn = 1 ;


select  book_name, 
RANK() over(partition by book_name  order by id ) rn from books ; 


#https://www.oracletutorial.com/oracle-analytic-functions/oracle-rank/

# ROW_NUMBER and RANK functions are similar. 
# The output of ROW_NUMBER is a sequence of values starts from 1 with an increment of 1 
# but whereas the RANK function, the values are also incremented by 1 
# but the values will repeat for the ties.
```


### rank vs dens_rank

```
# rank
java 1
java 1
java 3

# dense_rank
java 1
java 1
java 2

```

### Distinct

```sql
select distinct id from books; ## id will be sorted. (int)
select distinct book_name from books;  ## name will not be sorted. (varchars)
```
