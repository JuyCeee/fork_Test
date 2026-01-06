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
DROP TABLE special;
DROP TABLE cross_timetable_class;
DROP TABLE cross_timetable_teacher;
DROP TABLE cross_timetable_room;

-- We could also use INT for a couple of things and just number them through but at the end we'd prolly
-- have to make more tables. Also it mostly depends on how we recieve the info.

-- We'll have to check if I put the foreign keys in the right tables

-- Have to add n-n possibilities for tabled, otherwise should mostly be good

CREATE TABLE timetable (
    id INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    initials VARCHAR(10) NOT NULL,
    timetable_id INT,
    FOREIGN KEY (cross_timetable_id) REFERENCES cross_timetable_teacher(teacher_id)
);

CREATE TABLE room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num VARCHAR(10) NOT NULL,
    timetable_id INT,
    FOREIGN KEY (cross_timetable_id) REFERENCES cross_timetable_room(room_id)
);

CREATE TABLE absence (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    timetable_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
);

CREATE TABLE subject (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    shortened VARCHAR (10) NOT NULL,
    timetable_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
);

CREATE TABLE grade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mark FLOAT,
    weight FLOAT,
    timetable_id INT,
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES subject(id),
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
);

CREATE TABLE homework (
    id INT AUTO_INCREMENT PRIMARY KEY,
    txt VARCHAR(500),
    file BOOLEAN NOT NULL,
    title VARCHAR(100),
    timetable_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
);

CREATE TABLE message (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(500),
    timetable_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
);

CREATE TABLE class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    timetable_id INT,
    FOREIGN KEY (cross_timetable_id) REFERENCES cross_timetable_class(timetable_id)
);

CREATE TABLE times (
    id INT AUTO_INCREMENT PRIMARY KEY,
    time INT NOT NULL,
    timetable_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
);
CREATE TABLE special (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100) NOT NULL,
    timetable_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)

--Crosstables
    
CREATE TABLE cross_timetable_class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
    FOREIGN KEY (class_id) REFERENCES class(id)
);
CREATE TABLE cross_timetable_teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
);
CREATE TABLE cross_timetable_room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
    FOREIGN KEY (room_id) REFERENCES room(id)
);

--Temp Testdata

--INSERT INTO timetable () VALUES

INSERT INTO teacher (name, initials) VALUES
    ('Martin Lieberherr', 'LiM'),
    ('Marcel Naef', 'NaM'),
    ('Riccardo Ferrario', 'FeR');


INSERT INTO room (num) VALUES
    ('p342'),
    ('m513'),
    ('m423');

INSERT INTO absence (type, status) VALUES
    ('Verspätung', 'Entschuldigt'),
    ('Verspätung', 'Unentschuldigt'),
    ('Abwesend', 'Entschuldigt');

INSERT INTO subject (name, shortened, colour) VALUES
    ('Physik', 'Ph', '143,21,30'),
    ('Deutsch', 'D', '143,21,30'),
    ('Mathematik', 'M', '143,21,30');

INSERT INTO grade (mark, weight) VALUES
    (4.5, 1),
    (6, 1),
    (3.25, 2);

INSERT INTO homework (txt, file, title) VALUES
    ('Lesen S.20-21', false, 'Geschichte HA'),
    ('Aufgabe 34 a), b) und c)', true, 'Mathematik Aufgaben'),
    ('', false, 'Auftrag 3 lösen');

INSERT INTO message (message) VALUES
    ('Máté Levente Papp wird umgebracht'),
    ('Lektion verschoben ins Zimmer 422'),
    ('Louis ist tot');

INSERT INTO class (name) VALUES
    ('3h'),
    ('3g'),
    ('2h');

INSERT INTO times (time) VALUES
    (1766150400)
    (1766153700)
    (1766157000)


INSERT INTO special (type) VALUES
    ('Ausfall')
    ('Wintersporttag')
    ('Ausfall')
