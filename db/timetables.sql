DROP TABLE cross_timetable_absence;
DROP TABLE cross_timetable_room;
DROP TABLE cross_timetable_teacher;
DROP TABLE cross_timetable_class;
DROP TABLE timetable;
DROP TABLE special;
DROP TABLE class_;
DROP TABLE message;
DROP TABLE homework;
DROP TABLE subject;
DROP TABLE room;
DROP TABLE teacher;
DROP TABLE grade;
DROP TABLE absence;

CREATE TABLE absence (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
);

CREATE TABLE grade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mark FLOAT,
    weight FLOAT
);

CREATE TABLE teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    initials VARCHAR(10) NOT NULL
);

CREATE TABLE room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num VARCHAR(10) NOT NULL
);

CREATE TABLE subject (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    shortened VARCHAR (10) NOT NULL
);

CREATE TABLE homework (
    id INT AUTO_INCREMENT PRIMARY KEY,
    txt VARCHAR(500),
    file BOOLEAN NOT NULL,
    title VARCHAR(100)
);

CREATE TABLE message (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(500)
);

CREATE TABLE class_ (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL
);

CREATE TABLE special (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE timetable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT,
    homework_id INT,
    message_id INT,
    start_time BIGINT NOT NULL,
    end_time BIGINT NOT NULL,
    special_id INT,
    element_id INT,
    exam BOOLEAN NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subject(id),
    FOREIGN KEY (homework_id) REFERENCES homework(id),
    FOREIGN KEY (message_id) REFERENCES message(id),
    FOREIGN KEY (special_id) REFERENCES special(id)
);

CREATE TABLE cross_timetable_class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timetable_id INT,
    class_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id),
    FOREIGN KEY (class_id) REFERENCES class_(id)
);

CREATE TABLE cross_timetable_teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timetable_id INT,
    teacher_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
);

CREATE TABLE cross_timetable_room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timetable_id INT,
    room_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id),
    FOREIGN KEY (room_id) REFERENCES room(id)
);

CREATE TABLE cross_timetable_absence (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timetable_id INT,
    absence_id INT,
    FOREIGN KEY (timetable_id) REFERENCES timetable(id),
    FOREIGN KEY (absence_id) REFERENCES absence(id)
);
