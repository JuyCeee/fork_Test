import requests
from bs4 import BeautifulSoup
import datetime
#from your_app.models import Term

#Code von Patrik Weber

def login_to_tam(username, password, school) :
    session = requests.Session()
    url = 'https://intranet.tam.ch/'
    response = session.get(url)

    soup = BeautifulSoup(response.text, 'lxml')
    hash = str(soup.find('input', {'name': 'hash'}).get( 'value'))

    data = {
        'loginuser': username,
        'loginpassword': password,
        'loginschool': school,
        'hash': hash
    }

    response = session.post(url, data=data)

    csrf_token = response.text.split("csrfToken='")[1].split("';")[0]
    return session, csrf_token




def get_timetable_from_tam(cookies, class_id, teacher_id, start, end):
    #term = Term.objects.get(start__lte=start, end__gte=start)
                            
    start = datetime.datetime(start.year, start.month, start.day, 0, 0, 0)
    end = datetime.datetime(end.year, end.month, end.day, 23, 59, 59)

    headers = {
        'Referer': 'https://intranet.tam.ch/krm/timetable/classbook/period/' , #+str(term.tam_id),
        'X-Requested-With': 'XMLHttpRequest'
    }

    data = {
        'MIME Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'startDate': start.timestamp(),
        'endDate': end.timestamp(),
        'teacherId[]': teacher_id,
        'classId[]': class_id,
        'holidaysOnly': 0
    }

    url = 'https://intranet.tam.ch/krm/timetable/ajax-get-timetable'

    return get_json_from_tam(cookies, url, headers, data)['data']

def get_json_from_tam(cookies, url, headers, data):
    session = requests.Session()
    response = session.post(url, data=data, headers=headers, cookies=cookies)
    
    return response.json ()
