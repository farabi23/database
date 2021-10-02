-- a
SELECT * FROM course WHERE (credits > 3);

-- b
SELECT * FROM classroom WHERE (building = 'Packard' or building = 'Watson');

-- c
SELECT * FROM course WHERE dept_name = 'Comp. Sci.';

-- d
SELECT course.course_id, title, semester FROM course, section WHERE course.course_id = section.course_id and semester = 'Fall';

-- e
SELECT name, tot_cred FROM student WHERE tot_cred BETWEEN 45 AND 90;

-- f
SELECT name FROM student WHERE name LIKE '%a'
or name LIKE '%e'
or name LIKE '%i'
or name LIKE '%o'
or name LIKE '%u';

-- g
SELECT course.course_id, title, prereq_id FROM course, prereq
    WHERE course.course_id = prereq.course_id and prereq_id = 'CS-101';





-- a
select dept_name, avg (salary)
    from instructor
    group by dept_name
    ORDER BY avg(salary);

-- b


-- c
select dept_name,
       ( select count(*) from course
        where department.dept_name = course.dept_name)
        as num_courses
from department
order by num_courses; --it counts num of deps

-- d
select t.id, s.name
from takes as t, course as c, student as s
where c.course_id = t.course_id and c.dept_name = 'Comp. Sci.' and s.id = t.id
group by 1,2
having count(*) > 3;


-- e
SELECT name, dept_name FROM instructor
    WHERE dept_name = 'Biology'
       or dept_name = 'Music'
       or dept_name = 'Philosophy';

-- f
select distinct id
from teaches
where year = 2018 and
      id not in (select id
      from teaches
      where year= 2017);





-- a
SELECT distinct name
from student as s, takes as t
WHERE dept_name = 'Comp. Sci.' and (t.id = s.id and grade LIKE 'A%')
ORDER BY name;

-- b
SELECT distinct name
FROM takes, advisor, instructor
WHERE NOT grade LIKE 'A%' and takes.id = advisor.s_id and advisor.i_id = instructor.id;

-- c


-- d

-- e
SELECT distinct time_slot.time_slot_id, title
from time_slot, course, section
where end_hr < 13 and section.time_slot_id = time_slot.time_slot_id and course.course_id = section.course_id
order by time_slot.time_slot_id;


