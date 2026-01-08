import json
import mysql.connector
import re
from db import get_conn

#Checks if a value already exists in a table

def check_if_already_there(conn, table, attribute, value):
    cursor = conn.cursor(dictionary=True, buffered=True)
    sql = f"SELECT id FROM {table} WHERE {attribute}=%s"
    cursor.execute(sql, (value,))
    result = cursor.fetchone()
    return result


#Creating functions for filling / checking if already exist in tables and returning the id (the input datatype varies, depending on what it is in the json)


def insert_teacher(conn, namelist, acronymliststring):
    cursor = conn.cursor(dictionary=True, buffered=True)
    ids = []
    if namelist is not None:
        for i in range(len(namelist)):
            acronymlist = acronymliststring.split(",")
            FullNameString = namelist[i]
            AcronymString = acronymlist[i]
            x = check_if_already_there(conn, "teacher", "name", FullNameString)
            if not x:
                sql = "INSERT INTO teacher (name, initials) VALUES (%s, %s)"
                values = (FullNameString, AcronymString)

                cursor.execute(sql, values)
                conn.commit()
            
                x = cursor.lastrowid
                ids.append(x)
            else: 
                x = x["id"]
                ids.append(x)
    else:
        ids = None
    return ids

def insert_subject(conn, subjectstring, subjectshortstring):
    cursor = conn.cursor(dictionary=True, buffered=True)
    if subjectstring is not None:
        x = check_if_already_there(conn, "subject", "name", subjectstring)
        if not x:
            sql = "INSERT INTO subject (name, shortened) VALUES (%s, %s)"
            values = (subjectstring, subjectshortstring)

            cursor.execute(sql, values)
            conn.commit()
                
            x = cursor.lastrowid
            id = cursor.lastrowid
        else: 
            id = x["id"]
    else:
        id = None
    return id

def one_var_insert(conn, table, attribute, value):
    cursor = conn.cursor(dictionary=True, buffered=True)
    x = check_if_already_there(conn, table, attribute, value)
    if not x:
        sql = f"INSERT INTO {table} ({attribute}) VALUES (%s)"
        values = (value, )

        cursor.execute(sql, values)
        conn.commit()
            
        x = cursor.lastrowid
        id = x
    else: 
        id = x["id"]
    return id

def insert_class(conn, classnames):
    if classnames is not None:
        ids = []
        classnames = classnames.split(",")
        classlen = len(classnames)
        for i in range(classlen):
            classname = classnames[i]
            x = one_var_insert(conn, "class_", "name", classname)
            ids.append(x)
    else:
        ids = None       
    return ids
        
def insert_room(conn, roomnames):
    if roomnames is not None:
        ids = []
        roomnames = roomnames.split(",")
        roomlen = len(roomnames)
        for i in range(roomlen):
            roomname = roomnames[i]
            x = one_var_insert(conn, "room", "num", roomname)
            ids.append(x)
    else:
        ids = None
    return ids

def insert_message(conn, message):
    if message is not None:
        x = one_var_insert(conn, "message", "message", message)
    else:
        x = None
    return x

def insert_special(conn, special):
    if special is not None:
        x = one_var_insert(conn, "special", "type", special)
    else:
        x = None
    return x

def insert_homework(conn, txt, file, title):
    cursor = conn.cursor(dictionary=True, buffered=True)
    if file or title is not None:
        x = check_if_already_there(conn, "homework", "title", title)
        if not x:
            sql = "INSERT INTO homework (txt, file, title) VALUES (%s, %s, %s)"
            values = (txt, file, title)

            cursor.execute(sql, values)
            conn.commit()
                
            x = cursor.lastrowid
            id = x
        else: 
            id = x["id"]
    else:
        id = None
    return id

def insert_cross_table(conn, other_table, timetable_id, other_id_list):
    cursor = conn.cursor(dictionary=True, buffered=True)
    if other_id_list is not None:
        idlen = len(other_id_list)
        for i in range(idlen):
            other_id = other_id_list[i]
            sql = f"SELECT id FROM cross_timetable_{other_table} WHERE {other_table}_id=%s AND timetable_id=%s"
            cursor.execute(sql, (other_id, timetable_id))
            if not cursor.fetchone():
                sql = f"INSERT INTO cross_timetable_{other_table} (timetable_id, {other_table}_id) VALUES (%s, %s)"
                values = (timetable_id, other_id)

                cursor.execute(sql, values)
                conn.commit()
            else:
                pass
    else:
        pass
def insert_timetable(conn, subject_id, homework_id, message_id, start_time, end_time, special_id, element_id, exam):
    cursor = conn.cursor(dictionary=True, buffered=True)
    x = check_if_already_there(conn, "timetable", "element_id", element_id)
    if not x:
        sql = "INSERT INTO timetable (subject_id, homework_id, message_id, start_time, end_time, special_id, element_id, exam) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
        values = (subject_id, homework_id, message_id, start_time, end_time, special_id, element_id, exam)

        cursor.execute(sql, values)
        conn.commit()
            
        x = cursor.lastrowid
        id = x
    else: 
        id = x["id"]
    return id


#Taking all the seperate functions and making one that takes all the inputs and saves them and links them by their foreign key


def insert_whole_joint(conn, teachername, teacherinitials, roomnumber, subjectname, subjectnameshort, homeworktxt, homeworkfile, homeworktitle, messagemessage, classname, specialtype, starttime, endtime, timetableelementid, examvalue):
    starttime = int(re.search(r'\d+', starttime).group())
    endtime = int(re.search(r'\d+', endtime).group())
    teacherid = insert_teacher(conn, teachername, teacherinitials)
    roomid = insert_room(conn, roomnumber)
    subjectid = insert_subject(conn, subjectname, subjectnameshort)
    homeworkid = insert_homework(conn, homeworktxt, homeworkfile, homeworktitle)
    messagid = insert_message(conn, messagemessage)
    classid = insert_class(conn, classname)
    specialid = insert_special(conn, specialtype)
    timetableid = insert_timetable(conn, subjectid, homeworkid, messagid, starttime, endtime, specialid, timetableelementid, examvalue)
    insert_cross_table(conn, "teacher",timetableid, teacherid)
    insert_cross_table(conn, "room",timetableid, roomid)
    insert_cross_table(conn, "class",timetableid, classid)

#Final function that updates the data base

def upsert_db():
    conn = get_conn()
    with open("Intranet.json", "r") as f:
        data = json.load(f)
    data = data["data"]
    lenData = len(data)
    for i in range(lenData):
        teachername = data[i]["teacherFullName"]
        teacherinitials = data[i]["teacherAcronym"]
        roomnumber = data[i]["roomName"]
        subjectname = data[i]["subjectName"]
        subjectnameshort = data[i]["title"]
        homeworktxt = None
        homeworkfile = None
        homeworktitle = None
        messagemessage = data[i]["message"]
        classname = data[i]["className"]
        specialtype = data[i]["timetableEntryTypeId"]
        starttime = data[i]["start"]
        endtime = data[i]["end"]
        timetableelementid = data[i]["id"]
        examvalue = data[i]["isExamLesson"]
        insert_whole_joint(conn, teachername, teacherinitials, roomnumber, subjectname, subjectnameshort, homeworktxt, homeworkfile, homeworktitle, messagemessage, classname, specialtype, starttime, endtime, timetableelementid, examvalue)
