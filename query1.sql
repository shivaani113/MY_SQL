CREATE DATABASE DEPARTMENT;
USE DEPARTMENT;
CREATE TABLE IF NOT EXISTS DEPARTMENTS(DEPT_ID INT PRIMARY KEY,
DEPT_NAME VARCHAR(50) NOT NULL UNIQUE);
INSERT INTO DEPARTMENTS VALUES(1,'CSE'),(2,'ECE'),(3,'EEE'),
(4,'MECH'),(5,'CIVIL');
SELECT * FROM DEPARTMENTS;
CREATE TABLE IF NOT EXISTS STUDENTS(STUDENT_ID INT 
AUTO_INCREMENT PRIMARY KEY,STUDENT_NAME VARCHAR(50) NOT NULL,
EMAIL VARCHAR(50) UNIQUE,PHONE BIGINT,CGPA DECIMAL(3,2),
DEPT_ID INT ,
FOREIGN KEY(DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID)); 
DESC STUDENTS;
INSERT INTO STUDENTS (student_name, email, phone, cgpa, dept_id)
VALUES
('Kumar', 'kumar@gmail.com', 9876543210, 8.75, 1),
('Priya', 'priya@gmail.com', 9876543211, 9.10, 2),
('Rahul', 'rahul@gmail.com', 9876543212, 7.80, 3),
('Sneha', 'sneha@gmail.com', 9876543213, 8.95, 1),
('Arjun', 'arjun@gmail.com', 9876543214, 9.25, 4),
('Divya', 'divya@gmail.com', 9876543215, 8.40, 2),
('Ravi', 'ravi@gmail.com', 9876543216, 7.90, 3),
('Pooja', 'pooja@gmail.com', 9876543217, 9.50, 5),
('Vijay', 'vijay@gmail.com', 9876543218, 8.20, 4),
('Anitha', 'anitha@gmail.com', 9876543219, 9.00, 5);
SELECT * FROM STUDENTS;
CREATE TABLE IF NOT EXISTS COMPANIES(COMPANY_ID INT PRIMARY KEY,
COMPANY_NAME VARCHAR(50) UNIQUE);
INSERT INTO COMPANIES
VALUES
(1, 'TCS'),
(2, 'Infosys'),
(3, 'Accenture'),
(4, 'Wipro'),
(5, 'Cognizant');
SELECT * FROM COMPANIES;
CREATE TABLE IF NOT EXISTS JOBS
(JOB_ID INT AUTO_INCREMENT PRIMARY KEY,
ROLE_NAME VARCHAR(50) UNIQUE,MIN_CGPA DECIMAL(4,2),
COMPANY_ID INT NOT NULL,FOREIGN KEY(COMPANY_ID) REFERENCES 
COMPANIES(COMPANY_ID));
INSERT INTO JOBS (ROLE_NAME, MIN_CGPA, COMPANY_ID)
VALUES
('Java Developer', 7.00, 1),
('Python Developer', 7.50, 2),
('Full Stack Developer', 8.00, 3),
('Data Analyst', 6.50, 4),
('Software Engineer', 7.25, 5);
SELECT * FROM JOBS;
CREATE TABLE APPLICATIONS(APPLICATION_ID INT PRIMARY KEY,
STUDENT_ID INT, FOREIGN KEY(STUDENT_ID) REFERENCES 
JOBS(JOB_ID),STATUS VARCHAR(50));
INSERT INTO APPLICATIONS VALUES(1,1,'ACTIVE'),
(2,2,'ACTIVE'),(3,3,'NOTACTIVE'),(4,4,'NOTACTIVE'),
(5,5,'ACTIVE');
SELECT * FROM APPLICATIONS;
CREATE TABLE APTITUDE_TEST(TEST_ID INT AUTO_INCREMENT PRIMARY KEY,
STUDENT_ID INT,FOREIGN KEY(STUDENT_ID) REFERENCES 
STUDENTS(STUDENT_ID),MARKS INT);
INSERT INTO Aptitude_Test (student_id, marks)
VALUES
(1, 85),
(2, 78),
(3, 92),
(4, 67),
(5, 88),
(6, 74),
(7, 81),
(8, 95),
(9, 69),
(10, 90);
SELECT * FROM Aptitude_Test;
CREATE TABLE IF NOT EXISTS Interviews (
    interview_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    company_id INT NOT NULL,
    round_name VARCHAR(50) NOT NULL,
    result VARCHAR(20),
    
    FOREIGN KEY (student_id)
    REFERENCES Students(student_id),
    
    FOREIGN KEY (company_id)
    REFERENCES Companies(company_id)
);
INSERT INTO Interviews
(student_id, company_id, round_name, result)
VALUES
(1, 1, 'Aptitude', 'Selected'),
(2, 2, 'Technical', 'Selected'),
(3, 3, 'HR', 'Rejected'),
(4, 4, 'Technical', 'Pending'),
(5, 5, 'HR', 'Selected');
SELECT *
FROM Interviews;


INSERT INTO Interviews (student_id, company_id, round_name, result)
VALUES
(1,1,'Aptitude','Selected'),
(2,2,'Technical','Selected'),
(3,3,'HR','Rejected'),
(4,4,'Technical','Pending'),
(5,5,'HR','Selected');

SELECT * FROM Interviews;

CREATE TABLE IF NOT EXISTS Placements(
placement_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
company_id INT NOT NULL,
package_lpa DECIMAL(4,2),
FOREIGN KEY(student_id) REFERENCES Students(student_id),
FOREIGN KEY(company_id) REFERENCES Companies(company_id)
);

INSERT INTO Placements(student_id, company_id, package_lpa)
VALUES
(1,1,6.50),
(2,2,5.50),
(5,5,7.20),
(8,3,8.00),
(10,4,6.88);

SELECT * FROM Placements;

SELECT s.student_name,d.dept_name
FROM Students s
JOIN Departments d
ON s.dept_id=d.dept_id;

SELECT s.student_name,c.company_name
FROM Placements p
JOIN Students s ON p.student_id=s.student_id
JOIN Companies c ON p.company_id=c.company_id;

SELECT *
FROM Students
WHERE cgpa>8;

SELECT *
FROM Placements
WHERE package_lpa>5;

SELECT DISTINCT s.student_name
FROM Students s
JOIN Interviews i
ON s.student_id=i.student_id;

SELECT s.student_name
FROM Students s
JOIN Placements p
ON s.student_id=p.student_id;

SELECT student_name
FROM Students
WHERE student_id NOT IN
(
SELECT student_id
FROM Placements
);


SELECT COUNT(*) AS total_students
FROM Students;


SELECT AVG(cgpa) AS average_cgpa
FROM Students;

SELECT MAX(cgpa) AS highest_cgpa
FROM Students;


SELECT MIN(cgpa) AS lowest_cgpa
FROM Students;


SELECT dept_id,COUNT(*) AS student_count
FROM Students
GROUP BY dept_id;

SELECT company_id,COUNT(*) AS placed_students
FROM Placements
GROUP BY company_id;


SELECT dept_id,COUNT(*) AS total_students
FROM Students
GROUP BY dept_id
HAVING COUNT(*)>2;


SELECT company_id,COUNT(*) AS selected_students
FROM Placements
GROUP BY company_id
HAVING COUNT(*)>1;


SELECT dept_id,AVG(cgpa)
FROM Students
GROUP BY dept_id
HAVING AVG(cgpa)>8;
SELECT s.student_name,d.dept_name
FROM Students s
INNER JOIN Departments d
ON s.dept_id=d.dept_id;
SELECT s.student_name,c.company_name
FROM Placements p
JOIN Students s ON p.student_id=s.student_id
JOIN Companies c ON p.company_id=c.company_id;
SELECT c.company_name,j.role_name
FROM Companies c
JOIN Jobs j
ON c.company_id=j.company_id;
SELECT s.student_name,c.company_name
FROM Placements p
RIGHT JOIN Students s
ON p.student_id=s.student_id
LEFT JOIN Companies c
ON p.company_id=c.company_id;
SELECT student_name
FROM Students
WHERE student_id NOT IN
(
SELECT student_id
FROM Placements
);
SELECT *
FROM Students
WHERE cgpa=
(
SELECT MAX(cgpa)
FROM Students
);
SELECT *
FROM Students
WHERE cgpa>
(
SELECT AVG(cgpa)
FROM Students
);
SELECT *
FROM Placements
WHERE package_lpa=
(
SELECT MAX(package_lpa)
FROM Placements
);
SELECT s.student_name
FROM Students s
JOIN Placements p
ON s.student_id=p.student_id
JOIN Companies c
ON p.company_id=c.company_id
WHERE c.company_name='TCS';
SELECT DISTINCT s.student_name
FROM Students s
JOIN Interviews i
ON s.student_id=i.student_id
WHERE i.result='Rejected';
CREATE VIEW selected_students AS
SELECT s.student_name,
c.company_name,
p.package_lpa
FROM Placements p
JOIN Students s
ON p.student_id=s.student_id
JOIN Companies c
ON p.company_id=c.company_id;


SELECT *
FROM selected_students;


CREATE VIEW cgpa_above_8 AS
SELECT *
FROM Students
WHERE cgpa>8;


DELIMITER //

CREATE PROCEDURE DisplayStudents()
BEGIN
SELECT * FROM Students;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE StudentsByDept(IN did INT)
BEGIN
SELECT *
FROM Students
WHERE dept_id=did;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE DisplayPlacedStudents()
BEGIN
SELECT s.student_name,c.company_name,p.package_lpa
FROM Placements p
JOIN Students s
ON p.student_id=s.student_id
JOIN Companies c
ON p.company_id=c.company_id;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE InsertStudent(
IN sname VARCHAR(50),
IN semail VARCHAR(50),
IN sphone BIGINT,
IN scgpa DECIMAL(4,2),
IN did INT
)
BEGIN
INSERT INTO Students(student_name,email,phone,cgpa,dept_id)
VALUES(sname,semail,sphone,scgpa,did);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE UpdateCGPA(
IN sid INT,
IN newcgpa DECIMAL(4,2)
)
BEGIN
UPDATE Students
SET cgpa=newcgpa
WHERE student_id=sid;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER SetAppliedStatus
BEFORE INSERT
ON Applications
FOR EACH ROW
BEGIN
SET NEW.status='Applied';
END //

DELIMITER //

DELIMITER //

CREATE TRIGGER CheckCGPA
BEFORE INSERT
ON Students
FOR EACH ROW
BEGIN
IF NEW.cgpa<6 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='CGPA must be at least 6';
END IF;
END //

DELIMITER ;


CREATE TABLE Student_Backup AS
SELECT *
FROM Students
WHERE 1=0;

DELIMITER //

CREATE TRIGGER BackupStudent
BEFORE DELETE
ON Students
FOR EACH ROW
BEGIN
INSERT INTO Student_Backup
VALUES(
OLD.student_id,
OLD.student_name,
OLD.email,
OLD.phone,
OLD.cgpa,
OLD.dept_id
);
END //

DELIMITER ;