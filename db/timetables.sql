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
-- Times table maybe unneccesary cuz does not save anything, have to look into that, maybe just normally save it in timetable
-- Problem with grade and absences in how we currently do it, we do not have the student, only works in app not website

CREATE TABLE timetable (
    id INT AUTO_INCREMENT PRIMARY KEY
    absence_id INT,
    subject_id INT,
    grade_id INT,
    homework_id INT,
    message_id INT,
    start_time INT NOT NULL,
    end_time INT NOT NULL,
    special_id INT,
    FOREIGN KEY (absence_id) REFERENCES absence(id)
    FOREIGN KEY (subject_id) REFERENCES subject(id)
    FOREIGN KEY (grade_id) REFERENCES grade(id)
    FOREIGN KEY (homework_id) REFERENCES homework(id)
    FOREIGN KEY (message_id) REFERENCES message(id)
    FOREIGN KEY (times_id) REFERENCES times(id)
    FOREIGN KEY (special_id) REFERENCES special(id)
);

CREATE TABLE teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    initials VARCHAR(10) NOT NULL,
);

CREATE TABLE room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num VARCHAR(10) NOT NULL,
);

CREATE TABLE absence (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
);

CREATE TABLE subject (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    shortened VARCHAR (10) NOT NULL,
);

CREATE TABLE grade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mark FLOAT,
    weight FLOAT,
);

CREATE TABLE homework (
    id INT AUTO_INCREMENT PRIMARY KEY,
    txt VARCHAR(500),
    file BOOLEAN NOT NULL,
    title VARCHAR(100),
);

CREATE TABLE message (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(500),
);

CREATE TABLE class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
);

CREATE TABLE times (
    id INT AUTO_INCREMENT PRIMARY KEY,
    time INT NOT NULL
);
CREATE TABLE special (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100) NOT NULL
);

--Crosstables
    
CREATE TABLE cross_timetable_class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timetable_id INT,
    class_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
    FOREIGN KEY (class_id) REFERENCES class(id)
);
CREATE TABLE cross_timetable_teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timetable_id INT,
    teacher_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
);
CREATE TABLE cross_timetable_room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timetable_id INT,
    room_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id)
    FOREIGN KEY (room_id) REFERENCES room(id)
);

--Temp Testdata

--INSERT INTO timetable () VALUES

INSERT INTO teacher (name, initials) VALUES
    ('Naef Marcel', 'NaM'),
    ('Möckli Nicola', 'MoN'),
    ('Ferrario Riccardo', 'FeR'),
    ('Weber Schneider Barbara', 'WeB'),
    ('Fuchs Matthias', 'FuM'),
    ('Biron Laura', 'BiL');


INSERT INTO room (num) VALUES
    ('m513'),
    ('m503'),
    ('m423'),
    ('b326'),
    ('m401'),
    ('m501');

INSERT INTO subject (name, shortened) VALUES
    ('Deutsch', 'D'),
    ('Geographie', 'GG'),
    ('Mathematik', 'M'),
    ('Anwendungen der Mathematik', 'AM'),
    ('Biologie', 'B'),
    ('Geschichte', 'G'),
    ('Französisch', 'F');

INSERT INTO homework (txt, file, title) VALUES
    ('Lesen S.20-21', false, 'Geschichte HA'),

INSERT INTO message (message) VALUES
    ('WB "Kollaborative Unterrichtsgestaltung", Zi 525a/b'),

INSERT INTO class (name) VALUES
    ('3h'),

INSERT INTO special (type) VALUES
     ('Ausfall')

INSERT INTO cross_timetable_room (room_id, timetable_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 7);

INSERT INTO cross_timetable_class (class_id, timetable_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    (1, 7);

INSERT INTO cross_timetable_teacher (teacher_id, timetable_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 7);   

INSERT INTO timetable (subject_id, start_time, end_time, homework_id, message_id, special_id)
    (1, 1767595500000, 1767598200000, NULL, NULL, NULL ),
    (2, 1767598800000, 1767601500000, NULL, NULL, NULL ),
    (3, 1767602100000, 1767604800000, NULL, NULL, NULL ),
    (4, 1767605700000, 1767608400000, NULL, NULL, NULL ),
    (5, 1767609000000, 1767611700000, NULL, NULL, NULL ),
    (6, 1767615600000, 1767618300000, 1, NULL, NULL ),
    (7, 1767618900000, 1767621600000, NULL, 1, 1 );
