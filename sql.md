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
