
-- Create Students table
CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100) UNIQUE,
    created_at DATE DEFAULT SYSDATE
);

-- Create Teachers table
CREATE TABLE Teachers (
    teacher_id NUMBER PRIMARY KEY,
    name VARCHAR2(100)
);

-- Create Courses table
CREATE TABLE Courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(100),
    teacher_id NUMBER,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- Create Enrollments table (Many-to-Many relationship between Students and Courses)
CREATE TABLE Enrollments (
    student_id NUMBER,
    course_id NUMBER,
    enrollment_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data
INSERT INTO Students (student_id, name, email) VALUES (1, 'John Doe', 'john@example.com');
INSERT INTO Teachers (teacher_id, name) VALUES (1, 'Dr. Smith');
INSERT INTO Courses (course_id, course_name, teacher_id) VALUES (1, 'Math 101', 1);
INSERT INTO Enrollments (student_id, course_id) VALUES (1, 1);

-- Update student email
UPDATE Students SET email = 'newemail@example.com' WHERE student_id = 1;

-- Delete a student
DELETE FROM Students WHERE student_id = 1;

-- Commit changes
COMMIT;

-- Retrieve all students and their enrolled courses
SELECT Students.name, Courses.course_name 
FROM Students 
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id;

-- Find records created in the past 7 days
SELECT * FROM Students WHERE created_at >= SYSDATE - 7;

-- Retrieve top 5 highest values in each category (example using RANK)
SELECT course_id, student_id, RANK() OVER (PARTITION BY course_id ORDER BY enrollment_date DESC) AS rank 
FROM Enrollments 
WHERE rank <= 5;

-- Find entities with more than 3 related transactions
SELECT student_id, COUNT(*) AS transaction_count 
FROM Enrollments 
GROUP BY student_id 
HAVING COUNT(*) > 3;




