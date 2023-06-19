drop schema `collegeallotment_dbmsproject`; -- this query is to drop the whole schema and re-run

create schema `collegeallotment_dbmsproject`;

use collegeallotment_dbmsproject;


-- creating user table 
create table IF NOT EXISTS user(
uID VARCHAR(45) NOT NULL ,
email VARCHAR(45) NOT NULL,
pwd VARCHAR(45) NOT NULL,
accessLevel INT UNSIGNED NOT NULL,
PRIMARY KEY (uID)
);
select * from user;

-- creating student table
create table IF NOT EXISTS student(
uID VARCHAR(45) NOT NULL ,
sName VARCHAR(45) NOT NULL,
marks INT NOT NULL DEFAULT 0,
PRIMARY KEY (uID)
);

-- creating collegeadmin table
create table IF NOT EXISTS collegeadmin(
uID VARCHAR(45) NOT NULL ,
collegeName VARCHAR(45) NOT NULL,
collegeAddress TEXT(1000) NOT NULL,
collegeContactEmail VARCHAR(45) NOT NULL,
PRIMARY KEY (uID)
);

-- creating course table
CREATE TABLE IF NOT EXISTS `collegeallotment_dbmsproject`.`courses` (
  `courseID` INT NOT NULL,
  `courseName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`courseID`));
  

-- creating student_preferences table
CREATE TABLE IF NOT EXISTS `collegeallotment_dbmsproject`.`student_preferences` (
  `student_uID` VARCHAR(45) NOT NULL,
  `courseID` INT NOT NULL,
  `collegeadmin_uID` VARCHAR(45) NOT NULL,
  `preferenceNo` INT NOT NULL,
  PRIMARY KEY (`student_uID`, `courseID`,`collegeadmin_uID`),
  -- FOREIGN KEY (`student_uID`) REFERENCES `student` (`uID`),
  FOREIGN KEY (`courseID`) REFERENCES `courses` (`courseID`)
  -- FOREIGN KEY (`collegeadmin_uID`) REFERENCES `collegeadmin` (`uID`)
);

-- creating courses_offered table
CREATE TABLE IF NOT EXISTS `courses_offered` (
  `collegeadmin_uID` VARCHAR(45) NOT NULL,
  `courseID` INT NOT NULL,
  `coursecapacity` INT NOT NULL,
  `cutOff` INT NOT NULL,
  PRIMARY KEY (`collegeadmin_uID`, `courseID`)
  -- FOREIGN KEY (`collegeadmin_uID`) REFERENCES `collegeadmin`(`uID`) ON DELETE CASCADE,
 --  FOREIGN KEY (`courseID`) REFERENCES `courses`(`courseID`) -- 
);

-- adding cutOff in table
-- ALTER TABLE courses_offered
-- ADD COLUMN cutOff INT NOT NULL DEFAULT 100 AFTER coursecapacity;

-- creating allocated table
CREATE TABLE allocated (
  `student_uID` VARCHAR(45) NOT NULL,
  `courseID` INT NOT NULL,
  `collegeadmin_uID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_uID`),
  FOREIGN KEY (`courseID`) REFERENCES `courses` (`courseID`),
  FOREIGN KEY (`collegeadmin_uID`) REFERENCES `collegeadmin` (`uID`)
);

-- inserting sample data
INSERT INTO user values 
('15451', 'suraj@email.com', 'P@ssw0rd', 0), 
('15231', 'ria@email.com', 'P@ssw0rd', 0), 
('15415', 'kuhoo@email.com', 'P@ssw0rd', 0), 
('15670', 'karan@email.com', 'P@ssw0rd', 0), 
('15444', 'maanya@email.com', 'P@ssw0rd', 0), 
('14644', 'kartik@email.com', 'P@ssw0rd', 0), 
('15342', 'ayush@email.com', 'P@ssw0rd', 0), 
('14323', 'parth@email.com', 'P@ssw0rd', 0), 
('16743', 'vedant@email.com', 'P@ssw0rd', 0), 
('18934', 'agniva@email.com', 'P@ssw0rd', 0), 
('15405', 'aayush@email.com', 'P@ssw0rd', 0), 
('12452', 'divya@email.com', 'hello', 0),
('0001', 'collegeadmin@pilani.bits-pilani.ac.in', 'n1dnjf5f5j', 1),
('0002', 'collegeadmin@goa.bits-pilani.ac.in', 'lsd9n2kf0l', 1),    
('0003', 'collegeadmin@hyderabad.bits-pilani.ac.in', 'f9ksd4jdn3', 1),    
('0004', 'collegeadmin@bombay.iit.ac.in', '2dn3sdl4l4', 1),    
('0005', 'collegeadmin@delhi.iit.ac.in', 'sdf2nls9c2', 1),   
('0006', 'collegeadmin@kanpur.iit.ac.in', 'dfo4enl3e9', 1),   
('0007', 'collegeadmin@guwahati.iit.ac.in', 'kdfn5l2m5n', 1),   
('0008', 'collegeadmin@madras.iit.ac.in', 'sdjf3kldks', 1),   
('0009', 'collegeadmin@roorkee.iit.ac.in', 'asdn8fnm0s', 1);


INSERT INTO student VALUES 
('15451', 'Suraj', 269),
('15231', 'Ria', 271),
('15415', 'Kuhoo', 289),
('15670', 'Karan', 204),
('15444', 'Maanya', 234),
('14644', 'Kartik', 249),
('15342', 'Ayush', 278),
('14323', 'Parth', 255),
('16743', 'Vedant', 278),
('18934', 'Agniva', 201),
('15405', 'Aayush', 210),
('12452', 'Divya', 275),
('15232', 'Priya', 284),
('15416', 'Rohit', 263),
('15671', 'Neha', 225),
('15445', 'Rishi', 260),
('14645', 'Shreya', 272),
('15343', 'Sachin', 282),
('14324', 'Tanvi', 267),
('16744', 'Vivek', 291),
('18935', 'Amit', 190),
('15406', 'Alok', 285),
('12453', 'Naman', 254),
('15233', 'Radha', 279),
('15417', 'Pranav', 192),
('15672', 'Riya', 293),
('15446', 'Rajat', 197),
('14646', 'Saurabh', 225),
('15344', 'Tarun', 296),
('14325', 'Shivani', 282),
('16745', 'Yash', 243),
('18936', 'Aakash', 280),
('15407', 'Anjali', 248),
('12454', 'Sarika', 279),
('15234', 'Sahil', 219),
('15418', 'Swati', 226),
('15673', 'Sakshi', 258),
('15447', 'Varun', 189),
('14647', 'Ankita', 274),
('15345', 'Uday', 198),
('14326', 'Shubham', 251),
('16746', 'Zoya', 268),
('18937', 'Arjun', 281),
('15408', 'Arun', 270),
('12455', 'Divyansh', 273),
('15235', 'Preeti', 193),
('15419', 'Shubhankar', 239),
('15674', 'Shaili', 281),
('15448', 'Nehal', 230),
('14648', 'Kavita', 201),
('15346', 'Pooja', 255),
('14327', 'Siddharth', 291),
('16747', 'Himanshu', 289),
('18938', 'Harsh', 277),
('15409', 'Deepak', 259),
('12456', 'Aryan', 290),
('15236', 'Gaurav', 252),
('15420', 'Yogesh', 189),
('15675', 'Mukul', 232),
('15449', 'Riya', 294),
('14649', 'Rajesh', 201),
('15347', 'Ankur', 281),
('14328', 'Anjana', 272),
('16748', 'Kunal', 246);


INSERT INTO courses VALUES 
(1, 'Civil'),
(2, 'Chemical'),
(3, 'EEE'),
(4, 'ECE'),
(5, 'ENI'),
(6, 'Pharma'),
(7, 'CSE'),
(8, 'Mechanical'),
(9, 'Manufacturing');

-- arranging in descending order

select * from collegeallotment_dbmsproject.student
ORDER BY marks DESC;

-- query to give ranking to students
SELECT sname, marks, RANK() OVER (ORDER BY marks DESC) AS `rank`
FROM student;



INSERT INTO collegeadmin VALUES 
('0001', 'BITS Pilani, Pilani', 'Vidyavihar, Pilani - 333031', 'admin@pilani.bits-pilani.ac.in'),
('0002', 'BITS Pilani, Goa', 'Goa', 'admin@goa.bits-pilani.ac.in'),
('0003', 'BITS Pilani, Hyderabad', 'Hyderabad', 'admin@hyderabad.bits-pilani.ac.in'),
('0004', 'IIT Bombay', 'Mumbai', 'admin@bombay.iit.ac.in'),
('0005', 'IIT Delhi', 'Delhi', 'admin@delhi.iit.ac.in'),
('0006', 'IIT Kanpur', 'Kanpur', 'admin@kanpur.iit.ac.in'),
('0007', 'IIT Guwahati', 'Guwahati', 'admin@guwahati.iit.ac.in'),
('0008', 'IIT Madras', 'Madras', 'admin@madras.iit.ac.in'),
('0009', 'IIT Roorkee', 'Roorkee', 'admin@roorkee.iit.ac.in');



INSERT INTO courses_offered (collegeadmin_uID, courseID, courseCapacity, cutOff) VALUES
('0001', 1, 80, 214),
('0001', 2, 75, 154),
('0001', 3, 90, 125),
('0001', 4, 100, 183),
('0001', 5, 60, 215),
('0001', 6, 70, 130),
('0001', 7, 85, 154),
('0001', 8, 95, 128),
('0002', 1, 85, 181),
('0002', 3, 75, 164),
('0002', 5, 90, 169),
('0002', 6, 80, 146),
('0002', 7, 70, 179),
('0002', 8, 95, 193),
('0002', 9, 60, 159),
('0003', 1, 70, 122),
('0003', 2, 85, 184),
('0003', 3, 90, 156),
('0003', 4, 75, 132),
('0003', 6, 80, 160),
('0003', 7, 95, 176),
('0003', 8, 70, 157),
('0004', 1, 90, 180),
('0004', 2, 80, 205),
('0004', 3, 70, 157),
('0004', 4, 95, 197),
('0004', 5, 75, 202),
('0004', 7, 85, 190),
('0004', 8, 90, 111),
('0004', 9, 60, 130),
('0005', 1, 80, 166),
('0005', 2, 70, 201),
('0005', 4, 90, 189),
('0005', 5, 95, 180),
('0005', 6, 75, 123),
('0005', 7, 85, 178),
('0005', 8, 80, 175),
('0006', 1, 90, 159),
('0006', 2, 75, 198),
('0006', 4, 85, 154),
('0006', 5, 70, 165),
('0006', 6, 95, 115),
('0006', 7, 80, 179),
('0006', 9, 60, 192),
('0007', 1, 75, 169),
('0007', 3, 85, 161),
('0007', 5, 90, 204),
('0007', 7, 95, 173),
('0007', 8, 70, 203),
('0007', 9, 80, 202),
('0008', 1, 85, 151),
('0008', 2, 90, 205),
('0008', 3, 75, 166),
('0008', 4, 80, 156),
('0008', 5, 70, 109),
('0008', 6, 95, 167),
('0008', 7, 85, 132),
('0008', 8, 90, 177),
('0009', 1, 70, 127),
('0009', 2, 85, 115),
('0009', 3, 95, 184),
('0009', 4, 75, 175),
('0009', 5, 80, 117),
('0009', 6, 90, 156),
('0009', 9, 60, 191);




INSERT INTO student_preferences (student_uID, collegeadmin_uID, courseID, preferenceNo)
VALUES 
('15451', '0001', 1, 1),
('15451', '0003', 3, 2),
('15231', '0002', 2, 1),
('15231', '0005', 5, 2),
('15415', '0007', 7, 1),
('15415', '0009', 9, 2),
('15670', '0004', 4, 1),
('15670', '0006', 6, 2),
('15444', '0008', 8, 1),
('15444', '0001', 1, 2),
('14644', '0003', 3, 1),
('14644', '0002', 2, 2),
('15342', '0009', 9, 1),
('15342', '0007', 7, 2),
('14323', '0004', 4, 1),
('14323', '0006', 6, 2),
('16743', '0008', 8, 1),
('16743', '0001', 1, 2),
('18934', '0003', 3, 1),
('18934', '0002', 2, 2),
('15405', '0007', 7, 1),
('15405', '0009', 9, 2),
('12452', '0004', 4, 1),
('12452', '0006', 6, 2),
('15232', '0008', 8, 1),
('15232', '0001', 1, 2),
('15416', '0003', 3, 1),
('15416', '0002', 2, 2),
('15671', '0009', 9, 1),
('15671', '0007', 7, 2),
('15445', '0004', 4, 1),
('15445', '0006', 6, 2),
('14645', '0008', 8, 1),
('14645', '0001', 1, 2),
('15343', '0003', 3, 1),
('15343', '0002', 2, 2),
('14324', '0007', 7, 1),
('14324', '0009', 9, 2),
('16744', '0004', 4, 1),
('16744', '0006', 6, 2),
('18935', '0008', 8, 1),
('18935', '0001', 1, 2),
('15406', '0003', 3, 1),
('15406', '0002', 2, 2),
('12453', '0007', 7, 1),
('12453', '0009', 9, 2),
('15233', '0004', 4, 1),
('15233', '0006', 6, 2),
('15417', '0008', 8, 1),
('15417', '0001', 1, 2),
('15672', '0003', 3, 1),
('15672', '0006', 5, 2),
('15672', '0007', 4, 1),
('15446', '0009', 7, 1),
('15446', '0003', 3, 2),
('14646', '0004', 1, 2),
('14646', '0002', 2, 1),
('15344', '0007', 4, 2),
('15344', '0008', 8, 1),
('14325', '0008', 8, 2),
('14325', '0009', 9, 1),
('16745', '0002', 2, 2),
('16745', '0006', 5, 1),
('18936', '0001', 1, 1),
('18936', '0002', 2, 2),
('15407', '0005', 6, 1),
('15407', '0008', 8, 2),
('12454', '0005', 6, 2),
('12454', '0002', 2, 1),
('15234', '0009', 9, 2),
('15234', '0003', 3, 1),
('15418', '0004', 1, 2),
('15418', '0005', 6, 1),
('15673', '0007', 4, 1),
('15673', '0008', 8, 2),
('15447', '0004', 1, 2),
('15447', '0001', 1, 1),
('14647', '0003', 3, 2),
('14647', '0007', 4, 1),
('15345', '0008', 8, 1),
('15345', '0001', 1, 2),
('14326', '0005', 6, 1),
('14326', '0004', 1, 2),
('16746', '0004', 1, 2),
('16746', '0003', 3, 1),
('18937', '0003', 3, 1),
('18937', '0007', 4, 2),
('15408', '0009', 9, 1),
('15408', '0001', 1, 2),
('12455', '0009', 9, 2),
('12455', '0006', 5, 1),
('15235', '0005', 6, 1),
('15235', '0007', 4, 2),
('15419', '0003', 3, 2),
('15419', '0001', 1, 1),
('15674', '0001', 1, 2),
('15674', '0007', 4, 1),
('15448', '0008', 8, 2),
('15448', '0009', 9, 1),
('14648', '0001', 1, 1),
('14648', '0002', 2, 2),
('15346', '0003', 3, 1),
('15346', '0006', 5, 2),
('14327', '0004', 1, 2),
('14327', '0002', 2, 1);

-- queries

-- to fetch all entries in uID field of student table

select uID from collegeallotment_dbmsproject.student;

--   to update row entry for a given uID in table student, update student information
select * from collegeallotment_dbmsproject.student;
update collegeallotment_dbmsproject.student set sName = 'Ramesh', marks = 269 where uID = '15446';
select * from collegeallotment_dbmsproject.student where uID = '15446';

-- to delete the entry corresponding to a student uID in table student

delete from collegeallotment_dbmsproject.student where uID = '16746';

-- to count the number of students
set @counter = (select count(*) from collegeallotment_dbmsproject.student);
select @counter;

-- to delete all student entries in table student
-- commented as we do not want to delete all data
-- truncate table collegeallotment_dbmsproject.student;

-- to add a course to table courses in database

INSERT INTO collegeallotment_dbmsproject.courses VALUES (10, 'Data Science');

-- to fetch all entries in the courseID field of table courses

SELECT courseID from collegeallotment_dbmsproject.courses;

-- to fetch all entries in the courses

SELECT courseName, courseID from collegeallotment_dbmsproject.courses;

-- to fetch the courseName for a given courseID in table courses

select courseName from collegeallotment_dbmsproject.courses where courseID = 4;

-- to fetch the courseID for a given courseName in table courses

select courseID from collegeallotment_dbmsproject.courses where courseName = 'CSE';

--  to delete all entries in the table courses
SET FOREIGN_KEY_CHECKS=0;

-- truncate table collegeallotment_dbmsproject.courses;

SET FOREIGN_KEY_CHECKS=1;


-- adds a course to the courses offered by a college by inserting row in table courses_offered

INSERT into collegeallotment_dbmsproject.courses_offered VALUES ('0002', 4, 75, 208);

-- to get courseIDs of all courses offered by a college and insert into global list offeredCourseIDs

SELECT courseID from collegeallotment_dbmsproject.courses_offered where collegeadmin_uID = '0006';

-- to update selection criteria(cutOff score) of a given course offered by a given college

UPDATE collegeallotment_dbmsproject.courses_offered 
SET cutOff = 245 
WHERE collegeadmin_uID = '001' AND courseID = 7;

-- select distinct collegeadmin_uID from collegeallotment_dbmsproject.courses_offered where coursecapacity = 0;
-- select collegeadmin_uID, courseID from collegeallotment_dbmsproject.courses_offered where coursecapacity = 0;

-- to retrieve count of number of seats/capacity remaining in a college

SELECT collegeadmin_uID, sum(coursecapacity) as 'Remaining seats' from collegeallotment_dbmsproject.courses_offered where collegeadmin_uID = '0005';


-- to get uIDs of all students who have been alloted courses

select student_uID from collegeallotment_dbmsproject.allocated;

-- to fetch all studentIds allocated to a given college

select student_uID from collegeallotment_dbmsproject.allocated where collegeadmin_uID = '0007';

-- to fetch all studentIds allocated to a given college and given course

select student_uID from collegeallotment_dbmsproject.allocated where collegeadmin_uID = '0003' AND courseID = 7;

-- to add a preference for a student in the table student_preferences

SET FOREIGN_KEY_CHECKS=0;
 
INSERT INTO collegeallotment_dbmsproject.student_preferences VALUES ('15451', '4', 2, 6);

SET FOREIGN_KEY_CHECKS=1;

-- update prefernce number for a given student's preference in the table student_preferences

UPDATE collegeallotment_dbmsproject.student_preferences set preferenceNo = 3 where student_uID = '15451' AND collegeadmin_uID = '0001';
select * from collegeallotment_dbmsproject.student_preferences where student_uID = '15451';

-- authenticate user

select uID from collegeallotment_dbmsproject.user where email = 'ria@email.com' and pwd = 'P@ssw0rd';

-- get access level
select accessLevel from collegeallotment_dbmsproject.user where email = 'ria@email.com' and pwd = 'P@ssw0rd' ;


-- register student user
INSERT INTO collegeallotment_dbmsproject.user VALUES ('12679', 'bulla@email.com', 'randompassword', 0);
INSERT INTO collegeallotment_dbmsproject.student VALUES ('12679', 'Bulla' , 267);
select * from collegeallotment_dbmsproject.user where uId = '12679';
select * from collegeallotment_dbmsproject.student where uID = '12679';

-- regiser collegedmin user
INSERT INTO collegeallotment_dbmsproject.user VALUES ('0010', 'collegeadmin@mandi.iit.ac.in', 'mandilol', 1);
INSERT INTO collegeallotment_dbmsproject.collegeadmin VALUES ('0010', 'IIT Mandi',  'Mandi', 'admin@mandi.iit.ac.in' );
select * from collegeallotment_dbmsproject.user where uID = '0010';
select * from collegeallotment_dbmsproject.collegeadmin where uID = '0010';

-- get student data
SELECT * from collegeallotment_dbmsproject.student where uID = '15451';

-- get collegeadmin data
select * from collegeallotment_dbmsproject.collegeadmin where uID = '6';

-- retrieve count of number of seats available for a particular course in all colleges
select collegeadmin_uID, collegeName, courseCapacity from collegeallotment_dbmsproject.courses_offered 
inner join collegeallotment_dbmsproject.collegeadmin on collegeadmin_uID = uID where courseID = 7;



-- Retrieve a list of all students who have been allotted seats in a particular college and course.

select student_uID, sName
from collegeallotment_dbmsproject.allocated 
join student on allocated.student_uid = student.uid 
where collegeadmin_uID = '0008';

-- update a college's eligibility criteria

select * from courses_offered where collegeadmin_uID = '0004' AND courseID = 7;
UPDATE collegeallotment_dbmsproject.courses_offered set cutOff = 240 where collegeadmin_uID = '0004' AND courseID = 7;
select * from courses_offered where collegeadmin_uID = '0004' AND courseID = 7;

-- to allocate the students to the college

-- ordering students by marks/ranks and then looking at their preferences from 1 to n
CREATE VIEW rankpreflist as
SELECT student.uID, student.sName, student.marks, student_preferences.courseID, student_preferences.collegeadmin_uID, student_preferences.preferenceNo
FROM student
INNER JOIN student_preferences
ON student.uID = student_preferences.student_uID ORDER BY marks desc, preferenceNo asc;

select * from rankpreflist;

set @counter = (select count(*) from collegeallotment_dbmsproject.student);
select @counter;


-- select * from collegeallotment_dbmsproject.student_preferences inner join collegeallotment_dbmsproject.collegeadmin inner join collegeallotment_dbmsproject.courses;

select * from collegeallotment_dbmsproject.student_preferences inner join collegeallotment_dbmsproject.collegeadmin where student_uID = '15231';

-- select * from collegeallotment_dbmsproject.student_preferences natural join collegeadmin  natural join courses where student_uID ='15231';

-- arranging in ascending order of uID and preference
select * from student_preferences order by student_uID asc, preferenceNo asc;

DELIMITER $
CREATE PROCEDURE get_altmnt(courseID INT, collegeID VARCHAR(45), cap INT)
BEGIN
  SET @_courseID = courseID;
  SET @_collegeID = collegeID;
  SET @_cap = cap;
  PREPARE stmt FROM "insert into allocated(student_uID, courseID, collegeadmin_uID) select distinct student_uID, courseID, collegeadmin_uID from (select distinct  student_uID, courseID, collegeadmin_uID , marks, preferenceNo  from student natural join student_preferences natural join courses_offered 
where courseID = ? and collegeadmin_uid = ? and student.marks>= courses_offered.cutOff
order by  student.marks desc, student_preferences.preferenceNo asc limit ?) as T";
  EXECUTE stmt USING @_courseID, @_collegeID, @_cap ;
  DEALLOCATE PREPARE stmt;
END$

DELIMITER ;

-- drop procedure get_altmnt;

set @capacity = (select coursecapacity from courses_offered 
	where collegeadmin_uid = '0001' and courseid= 1);
call get_altmnt(1 , '0001', @capacity);
-- call get_altmnt(9 , '9', @capacity);

select * from collegeallotment_dbmsproject.courses join collegeallotment_dbmsproject.courses_offered;

select * from collegeallotment_dbmsproject.allocated;

-- List of a number of applications received for a particular college and course.

select collegeadmin_uID, courseID, count(student_uID) from collegeallotment_dbmsproject.student_preferences group by collegeadmin_uID, courseID order by collegeadmin_uID;

-- Retrieve a count of the number of applications received for a particular college and course.

select count(student_uID) AS 'Number of students gave a preference for given college and course' from collegeallotment_dbmsproject.student_preferences where collegeadmin_uID = '1' AND courseID = '1';

-- Retrieve a list of all colleges that have filled all their seats.

SELECT distinct collegeName from collegeallotment_dbmsproject.allocated join collegeallotment_dbmsproject.collegeadmin;

select * from collegeallotment_dbmsproject.collegeadmin;




