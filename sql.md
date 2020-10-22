



### Remove duplicate
```
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

```
select distinct id from books; ## id will be sorted. (int)
select distinct book_name from books;  ## name will not be sorted. (varchars)
```