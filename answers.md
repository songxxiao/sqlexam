这一套多表联结练习题适合刚刚学习SQL语法后，对知识进行巩固。这次发的是带有参考答案的版本，请注意每道题的答案并不是唯一的，答案仅供参考。建议本套题


代码规范请遵照[Alibaba SQL代码编码原则和规范](https://www.alibabacloud.com/help/zh/doc-detail/137491.htm)。参考答案遵循MySQL语法。

表结构如下：  
```
Student(Sid,Sname,Sage,Ssex) 学生表 sid为key  
Course(Cid,Cname,Tid) 课程表 cid 为key  
SC(Sid,Cid,score) 成绩表 (sid, cid) 为key  
Teacher(Tid,Tname) 教师表 tid为key  
```

### Day 1

1. 查询选修了“计算机原理”的学生学号和姓名；

```sql
select Sid, Sname
from Student
join SC on Student.Sid = SC.Sid
where Cid in (
    select distinct Cid
    from Course
    where Cname = '计算机原理'
)
  and score is not null
group by 1, 2;
```

2. 查询“周星驰”同学选修了的课程编号和课程名称；  

```sql
select Cid, Cname
from Course
join SC on Course.Cid = SC.Cid
where Sid in (
    select distinct Sid
    from Student
    where Sname = '周星驰'
)
  and score is not null
group by 1, 2;
```


3. 查询选修了5门课程的学生学号和姓名；  

```sql
select Student.Sid
     , Student.Sname
from SC
   , Student
where SC.Sid = Student.Sid
group by 1
having count(SC.Cid) = 5;
```

### Day 2

4. 查询“001”课程比“002”课程成绩高的所有学生的学号（注：学生同时选修了这两门课）；

```sql
select Sid 
from
(
    select Sid
          , if(Cid='001', Score, null) as course1
          , if(Cid='002', Score, null) as course2
    from SC 
    left join Student 
    group by 1,2,3
) a where course1 > course2;
```

5. 查询“003”课程的学生成绩情况，要求输出学生学号，姓名和成绩情况（大于或等于80表示优秀，大于或等于60表示及格，小于60分表示不及格）；

```sql
select b.sid,
       a.sname,
       case
           when score >= 80 then '优秀'
           when score >= 60 then '及格'
           else '不及格' end grades
from Student a
join SC b on a.sid = b.sid
where cid = '003';
```

6. 查询平均成绩大于60分的同学的学号、姓名和平均成绩；

```sql
select b.sid,
       a.sname,
       avg(score) "平均成绩"
from Student a
join SC b on a.sid = b.sid
group by 1,2
having avg(score) > 60;
```

### Day 3

7. 查询所有同学的学号、姓名、选课数、总成绩；

```sql
select  s.Sid
	  , s.Sname
	  , count(distinct sc.Cid) as c_count
	  , sum(sc.score)
from Student s 
join SC sc on s.Sid = sc.Sid
group by 1, 2;
```

8. 查询姓“杨”的老师的人数；

```sql
select count(distinct Tid) as t_count
from Teacher
where Tname like '杨%';
```

9. 查询没学过“张三”老师课的同学的学号、姓名；

```sql
select sid,
       sname
from Student
where sid not in (
    select sid
    from SC a
    join Course b on a.cid = b.cid
    join Teacher c on b.tid = c.tid
    where tname = '张三'
);
```

### Day 4

10. 查询学过“001”并且也学过“002”课程的同学的学号、姓名；

```sql
select Sid
from (
         select Sid
              , count(Sid)
         from (
                  select c.Sid as Sid
                  from SC a
                  join Student c on c.Sid = a.Sid
         where SC.cid in ('001', '002')
    ) a
    group by 1
    having count(Sid) > 1
) b;
```

11. 查询学过“李四”老师所教的所有课的同学的学号、姓名；

```sql
select a.sid, sname
from sc a
join student b on a.sid = b.sid
where a.cid in (
    select c.cid
    from course c
    join teacher d on c.tid = d.tid
    where tname = '李四'
);
```

12. 查询所有课程成绩小于60分的同学的学号、姓名；

```sql
select Sid
     , Sname
from (
   select c.Sid        as Sid
        , max(c.Sname) as Sname
        , max(ifnull(score,0))   as max_score
   from SC a
   left join Student c on c.Sid = a.Sid
   group by 1
     ) a
where max_score < 60
```

### Day 5

13. 查询选修了所有选修课程的同学的学号和姓名；

```sql
select sid
     , sname
from 
(
    select a.sid,a.sname,
    count(distinct b.cid) c 
    from student a 
    left join sc b on a.sid = b.sid 
    group by 1,2
    having c=(select count(distinct cid) from course)
) a;
```
14. 查询没有学全所有课的同学的学号、姓名；

```sql
select Sid, Sname
from(
    select s.Sid as Sid
       , max(s.Sname) as Sname
       , count(distinct sc.Cid) as course_num
    from Student s 
    join SC sc on s.Sid = sc.Sid
    join Teacher t on c.Tid = t.Tid 
    group by 1   
) a
where course_num < (select count(distinct Cid) from Course);
```

15. 查询至少有一门课与学号为“001”的同学所学相同的同学的学号和姓名；

```sql
select a.sid,
       sname
from student a
join sc b on a.sid = b.sid
where a.sid <> '001'
 and cid in (
    select cid
    from sc
    where sid = '001'
     and score is not null
)
group by 1, 2;
```

### Day 6

16. 查询至少学过学号为“001”同学所有一门课的其他同学学号和姓名；

```sql
select  s.Sid 
	  , s.Sname 
from Student s 
join SC sc on s.Sid = sc.Sid
join 
(
	select distinct sc.Cid
	from SC sc
	where Sid = '001'
) a on a.Cid = sc.Cid
where s.Sid <> '001'
group by 1, 2
having count(distinct sc.Cid) = 1;
```

17. 查询和“002”号的同学学习的课程完全相同的其他同学学号和姓名；

```sql
select  s.Sid 
	  , s.Sname 
from Student s 
join SC sc on s.Sid = sc.Sid and Sid <> '002'
join 
(
	select  distinct sc.Cid
		  , (select count(distinct Cid) from SC where Sid = '002') as t_count
	from SC sc
	where Sid = '002' 
) a on a.Cid = sc.Cid
group by 1, 2
having count(distinct sc.Cid) = a.t_count;
```


18. 按平均成绩从低到高显示所有学生的“语文”、“数学”、“英语”三门的课程成绩，按如下形式显示：学生ID,语文,数学,英语,有效课程数,有效平均分；

```sql
select  Sid
	  , max(if(Cname = '语文',score,0)) as "语文"
	  , max(if(Cname = '数学',score,0)) as "数学"
	  , max(if(Cname = '英语',score,0)) as "英语"
	  , sum(if(score is null,0,1)) 		as "有效课程数"
	  , avg(score) 					    as "有效平均分"
from SC
group by 1
order by avg(score);
```

### Day 7

19. 查询选修了5门课程的学生学号和姓名；

```sql
select s.Sid as Sid
      , max(s.Sname) as Sname
      , count(distinct sc.Cid) as C_count
from Student s 
join sc on s.Sid = sc.Sid
group by 1
having C_count = 5;
```

20. 查询学生平均成绩及其名次；

```sql
select  s.Sid 
	  , s.Sname 
	  , avg(ifnull(sc.score,0)) as avg_score
	  , row_number() over(order by avg(ifnull(sc.score,0)) desc) as rank
from Student s 
join SC sc on s.Sid = sc.Sid
group by 1, 2;
```

21. 查询各科成绩最高和最低的分，以如下形式显示：课程ID，最高分，最低分；

```sql
select cid
    , max(score) as m
    , min(score) as c
from sc
group by 1;
```

### Day 8

22. 按各科平均成绩从低到高和及格率的百分数从高到低顺序；

```sql
select Cid
      , avg(ifnull(score,0)) as avg_acore
      , count(if(score>60,Cid,null)) / count(Cid) as '及格率'
from SC
order by 1, 2 desc;
```

23. 查询如下课程平均成绩和及格率的百分数(注：需要在1行内显示): 企业管理（002），OO&UML （003），数据库（004）；

```sql
select Cid
    , max(if(Cid = '002', avg_score,0)) as '企业管理平均成绩'
    , max(if(Cid = '003', avg_score,0)) as 'OO&UML平均成绩'
    , max(if(Cid = '004', avg_score,0)) as '数据库平均成绩'
    , max(if(Cid = '002', pass_rate,0)) as '企业管理及格率'
    , max(if(Cid = '003', pass_rate,0)) as 'OO&UML及格率'
    , max(if(Cid = '004', pass_rate,0)) as '数据库及格率'
from(
    select Cid
        , avg(score) as avg_score
        , sum(if(score >= 60,1,0))/count(score) as pass_rate
    from SC
    group by 1
) a 
where Cid in ('002','003','004')
group by 1;
```

24. 查询老师所教课程平均分从高到低显示，以如下形式显示：课程ID，课程名，教师ID，教师名，课程平均分；

```sql
select  c.Cid
	  , c.Cname
	  , t.Tid
	  , t.Tname
	  , avg(sc.score) as avg_score
from SC sc
join Course c on sc.Cid = c.Cid
join Teacher t on c.Tid = t.Tid
group by 1, 2, 3, 4
order by avg(sc.score) desc;
```

### Day 9

25. 查询各科成绩,各分数段人数:课程ID,课程名称,[100-85],(85-70],(70-60],[ <60]

```sql
select  c.Cid
	  , c.Cname
	  , case when sc.score >= 85 then '[100-85]'
	  	     when sc.score >= 70 then '[85-70]'
	  	     when sc.score >= 60 then '[70-60]'
	  	else '[ <60]' end as score
	  , count(distinct sc.Sid) as s_count
from SC sc
join Course c on sc.Cid = c.Cid
group by 1, 2, 3;
```

26. 查询每门课程被选修的学生数，以如下形式显示：课程ID，课程名，选修人数；

```sql
select  c.Cid
	  , c.Cname
	  , count(distinct sc.Sid) as s_count
from SC sc
join Course c on sc.Cid = c.Cid
group by 1, 2;
```

27. 查询出只选修了一门课程的全部学生的学号和姓名；

```sql
select Sid
      ,Sname
from (
    select s.Sid as Sid
         , max(s.Sname) as Sname
         , count(distinct SC.Cid) as c_count
    from SC
    join Student s on s.Sid = SC.Sid
    group by 1
    having c_count = 1
) a;
```

### Day 10

28. 查询男生的人数；

```sql
select count(distinct Sid) as 
from Student 
where Ssex = '男';
```

29. 查询姓“李”的学生名单；

```sql
select Sname
from Student
where Sname like '李%';
```

30. 查询同名同姓学生名单，并统计同名人数；

```sql
select Sname
     , count(distinct Sid) '人数'
from Student
group by 1
having count(distinct Sid) > 1;
```

### Day 11

31. 查询1988年出生的学生名单（注：Student表中Sage列的类型是datetime）；

```sql
select Sname
from Student
where year(Sage) = 1988
```

32. 查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列；

```sql
select Cid
     , avg(ifnull(score, 0)) as avg_score
from SC 
group by 1
order by avg_score, Cid desc;
```

33. 查询课程名称为“数学”，且分数低于60的学生学号、姓名和分数；

```sql
select  s.Sid
	  , s.Sname
	  , s.score
from Student s
join SC sc on s.Sid = sc.Sid
join Course c on sc.Cid = c.Cid
where c.Cname = '数学'
  and c.score < 60
group by 1,2,3;
```

### Day 12

34. 查询课程成绩在70分以上的学号、姓名、课程名称和分数；

```sql
select  s.Sid 
	  , s.Sname
	  , c.Cname
	  , sc.score
from Student s
join SC sc on s.Sid = sc.Sid 
join Course c on sc.Cid = c.Cid 
where sc.score >= 70
group by 1, 2, 3, 4;
```

35. 查询有学生不及格的课程，并按课程号从大到小排列；

```sql
select cid
     , max(c.Cname) as Cname
from SC
join Course c on c.Cid = s.Cid
group by 1
having min(score) < 60
order by cid desc;
```

36. 查询课程编号为“003”且课程成绩在80分以上的学生的学号和姓名；

```sql
select  s.Sid 
	  , s.Sname
from Student s
join SC sc on s.Sid = sc.Sid 
where sc.Cid = '003'
  and sc.score >= 80
group by 1, 2;
```

### Day 13

37. 查询选修了课程的学生人数；

```sql
select count(distinct Sid) as stu_num
from SC
```

38. 查询选修“王五”老师所授课程的学生中，成绩最高的学生学号、姓名及其成绩；

```sql
select sid,
       sname,
       score
from (
         select a.sid,
                d.sname,
                a.score,
                rank() over (order by a.score desc) as rank
         from sc a
         join course b on a.cid = b.cid
         join teacher c on b.tid = c.tid
         join student d on a.sid = d.sid
         where c.tname = '王五'
     ) t
where rank = 1;
```

39. 查询各个课程ID、课程名及相应的选修人数；

```sql
select c.Cid as Cid
     , max(c.Cname) as Cname
     , count(distinct sc.Sid) as stu_number
from SC sc
join Course c on c.Cid = sc.Cid
group by 1;
```

### Day 14

40. 查询不同课程但成绩相同的学生的学号、课程号、学生成绩；

```sql
select sid,
       cid,
       score
from (
         select cid,
                sid,
                score,
                sum(1) over (partition by sid,score) as cnt
         from sc
     ) a
where cnt > 1;
```

41. 统计每门课程的学生选修人数（超过10人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列；

```sql
select Cid
     , stu_num
from (
   select Cid 
   count(distinct Sid) as stu_num
   from SC
   group by 1
   having stu_num > 10
) a 
order by stu_num desc, Cid;
```

42. 查询全部学生都选修的课程的课程号和课程名；

```sql
select SC.Cid
     , Cname
from SC 
join Course
on SC.Cid = Course.Cid
group by 1, 2
having count(distinct Sid) = (select count(distinct Sid) from Student);
```

### Day 15

43. 查询两门以上不及格课程的同学的学号及其平均成绩；

```sql
select  sc.Sid
	  , avg(sc.score) as avg_score
from SC sc
group by 1
having sum(if(sc.score < 60,1,0))>2;
```

44. 查询“004”课程分数小于60，按分数降序排列的同学学号和姓名；

```sql
select sc.Sid
     , s.Sname
from SC sc 
join Student s on s.Sid = sc.Sid
where Cid = '004' and score < 60
order by score desc;
```

45. 查询“化学课”成绩第11-20名学生学号和姓名（注：不用考虑分数相同的情况）

```sql
select  s.Sid
	  , s.Sname
from Student s
join SC sc on s.Sid = sc.Sid
join Course c on sc.Cid = c.Cid
where c.Cname = '化学课'
order by sc.score desc 
limit 10,10;

-- 或
select Sid
       , Sname
from(
      select sc.Sid as Sid
        , s.Sname as Sname 
        , row_number() over (order by sc.score desc) as ranking
      from SC sc
      join Course c on c.Cid = sc.Cid
      join Student s on s.Sid = sc.Sid
      where Cname = '化学' ) a
where ranking >= 11 and ranking <= 20;
```