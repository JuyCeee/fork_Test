DROP TABLE timetable;
DROP TABLE teacher;
DROP TABLE room;
DROP TABLE absence;
DROP TABLE subject;
DROP TABLE grade;
DROP TABLE homework;
DROP TABLE message;
DROP TABLE class;
DROP TABLE times;

--We could also use INT for a couple of things and just number them through but at the end we'd prolly
--have to make more tables. Also it mostly depends on how we recieve the info.

--We'll have to check if I put the foreign keys in the right tables

--Have to add n-n possibilities for tabled, otherwise should mostly be good

CREATE TABLE timetable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY teacher_id REFERENCES teacher(id)
    FOREIGN KEY room_id REFERENCES room(id)
    FOREIGN KEY absence_id REFERENCES absence(id)
    FOREIGN KEY subject_id REFERENCES subject(id)
    FOREIGN KEY grade_id REFERENCES grade(id)
    FOREIGN KEY homework_id REFERENCES homework(id)
    FOREIGN KEY message_id REFERENCES message(id)
    FOREIGN KEY class_id REFERENCES class(id)
    FOREIGN KEY times_id REFERENCES times(id)
    FOREIGN KEY special_id REFERENCES special(id)
);

CREATE TABLE teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    initials VARCHAR(10) NOT NULL,
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);

CREATE TABLE room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    number VARCHAR(10) NOT NULL,
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);

CREATE TABLE absence (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);

CREATE TABLE subject (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    shortened VARCHAR (10) NOT NULL,
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);

CREATE TABLE grade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mark FLOAT,
    weight FLOAT,
    FOREIGN KEY subject_id REFERENCES subject(id)
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);

CREATE TABLE homework (
    id INT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(500),
    file BOOLEAN NOT NULL,
    title VARCHAR(100),
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);

CREATE TABLE message (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(500),
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);

CREATE TABLE class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);

CREATE TABLE times (
    id INT AUTO_INCREMENT PRIMARY KEY,
    time INT NOT NULL,
    FOREIGN KEY timetable_id REFERENCES timetable(id)
);
CREATE TABLE special (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100) NOT NULL,
    FOREIGN KEY timetable_id REFERENCES timetable(id)


--Temp Testdata

--INSERT INTO timetable () VALUES

INSERT INTO teacher (name, initials) VALUES
    (Martin Lieberherr, LiM),
    (Marcel Naef, NaM),
    (Riccardo Ferrario, FeR);


INSERT INTO room (number) VALUES
    (p342),
    (m513),
    (m423);

INSERT INTO absence (type, status) VALUES
    (Verspätung, Entschuldigt),
    (Verspätung, Unentschuldigt),
    (Abwesend, Entschuldigt);

INSERT INTO subject (name, shortened) VALUES
    (Physik, Ph),
    (Deutsch, D),
    (Mathematik, M);

INSERT INTO grade (mark, weight) VALUES
    (4.5, 1),
    (6, 1),
    (3.25, 2);

--INSERT INTO homework (text, file, title) VALUES

--INSERT INTO message (message) VALUES

INSERT INTO class (name) VALUES
    (3h),
    (3g),
    (2h);

--INSERT INTO times (time) VALUES

--INSERT INTO special (type) VALUES
