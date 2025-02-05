-- 1
CREATE TABLE students( student_id INT PRIMARY KEY, name VARCHAR(50), age INT);
-- 2
CREATE TABLE courses( course_id INT PRIMARY KEY, course_name VARCHAR(100), credits INT DEFAULT 3);
-- 3
CREATE TABLE enrollments(enrollment_id INT AUTO_INCREMENT PRIMARY KEY, student_id INT, course_id INT,
 FOREIGN KEY (student_id) REFERENCES students(student_id), FOREIGN KEY (course_id) REFERENCES courses(course_id) );
-- 4
ALTER TABLE students 
CHANGE age student_age INT;
-- 5
ALTER TABLE courses
CHANGE credits course_credits INT DEFAULT 3;
-- 6
RENAME TABLE students TO learners;
-- 7
ALTER TABLE courses RENAME TO subjects; 
-- 8
INSERT INTO learners VALUES(1, 'Alice', 20);
-- 9
INSERT INTO learners VALUES(5, 'Ross', 19),(12, 'Monica', 19);
-- 10
INSERT INTO subjects VALUES(101, 'Mathematics', 4);
-- 11
SET SQL_SAFE_UPDATES = 0;
UPDATE learners
SET student_age=21
WHERE student_id=1;
-- 12
SET SQL_SAFE_UPDATES = 0;
UPDATE subjects
SET course_name='Advanced Mathematics'
WHERE course_id=101;
-- 13
SET SQL_SAFE_UPDATES = 0;
UPDATE learners
SET student_age = student_age + 1;
-- 14
DELETE FROM learners 
WHERE student_id=1;
-- 15
DELETE FROM subjects
WHERE course_credits<3;
-- 16
TRUNCATE TABLE enrollments;
-- 17
SELECT * FROM learners;
-- 18
SELECT name, student_age
FROM learners;
-- 19
SELECT DISTINCT course_name
FROM subjects;
-- 20
SELECT student_age, COUNT(student_age) AS numbers
FROM learners
GROUP BY student_age;
-- 21
SELECT course_credits, COUNT(course_credits) AS amount
FROM subjects
GROUP BY course_credits;
-- 22
SELECT student_age, COUNT(student_age) AS number
FROM learners
GROUP BY student_age
HAVING COUNT(student_age) > 2;
-- 23
SELECT course_id, COUNT(student_id) AS classTotal
FROM enrollments
GROUP BY course_id
HAVING COUNT(student_id)>5;
-- 24
SELECT * FROM learners
LIMIT 5;
-- 25
SELECT * FROM subjects
ORDER BY course_credits DESC
LIMIT 3;
-- 26
SELECT * FROM learners
LIMIT 5 OFFSET 5;
-- 27
SELECT * FROM subjects
ORDER BY course_id DESC
LIMIT 3 OFFSET 3;
-- 28
SELECT name FROM learners
UNION 
SELECT course_name FROM subjects;
-- 29
SELECT * FROM learners
WHERE student_age < 20
UNION 
SELECT * FROM learners
WHERE student_age > 25;
-- 30 ?
SELECT course_name FROM subjects
UNION ALL
SELECT course_name FROM subjects;
-- 31 ?
SELECT * FROM students
UNION ALL
SELECT * FROM learners;
-- 32 ? 
SELECT student_id, name, student_age FROM learners WHERE student_age BETWEEN 20 AND 25
INTERSECT
SELECT student_id, name, student_age FROM learners WHERE student_age BETWEEN 23 AND 30 ORDER BY student_id;
-- 33
SELECT course_name FROM subjects
INTERSECT
SELECT course_name FROM completed_courses ORDER BY course_name;
-- 34
SELECT student_id FROM learners
EXCEPT
SELECT student_id FROM enrollments ORDER BY student_id;
-- 35
SELECT student_id FROM enrollments
EXCEPT
SELECT student_id FROM learners ORDER BY student_id;
-- 36
SELECT *, e.course_id
FROM learners l 
JOIN enrollments e USING(student_id);
-- 37
SELECT s.course_name
FROM subjects s
JOIN enrollments e USING(course_id);
-- 38
SELECT *, e.course_id 
FROM learners l 
LEFT JOIN enrollments e ON l.student_id=e.student_id;
-- 39
SELECT *, e.student_id
FROM subjects s 
LEFT JOIN enrollments e ON s.course_id=e.course_id;
-- 40 ?
SELECT *, e.course_id
FROM learners l
FULL JOIN enrollments e ON l.student_id=e.student_id;
-- 41 ?
SELECT *, s.course_id, s.course_name
FROM learners l
FULL JOIN subjects s;
-- 42
SELECT *, s.course_id, s.course_name, s.course_credits
FROM learners l
CROSS JOIN subjects s;
-- 43
SELECT *, (student_id*1) AS common FROM learners CROSS JOIN learners
UNION
SELECT *, 'none' AS common FROM learners CROSS JOIN subjects
UNION
SELECT *, (l.student_id*1) AS common FROM learners l CROSS JOIN enrollments;
-- 44
SELECT student_age FROM learners
ORDER BY student_age
LIMIT 1 OFFSET 1;
-- 45
SELECT course_id, COUNT(student_id) AS number
FROM enrollments e 
JOIN learners l USING(student_id)
GROUP BY course_id
ORDER BY number DESC LIMIT 1;
-- 46

