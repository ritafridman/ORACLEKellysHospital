import json
import os ,time
import cx_Oracle
from flask import render_template
from flask import Flask, redirect, url_for, request , jsonify
from flask_bootstrap import Bootstrap


db_user = os.environ.get('DBAAS_USER_NAME', 'SYSTEM')
db_password = os.environ.get('DBAAS_USER_PASSWORD', 'Sagi2019')
db_connect = os.environ.get('DBAAS_DEFAULT_CONNECT_DESCRIPTOR', "localhost:1521/xe")
service_port = port=os.environ.get('PORT', '8080')
connection = cx_Oracle.connect(db_user , db_password ,db_connect)
cur = connection.cursor()




patientsDoctorsView = "CREATE VIEW Patients_Doctors AS SELECT  P.ID AS Patients_ID  , P.first_name || '  ' ||  P.last_name AS Patients , E.ID AS Doctor_ID , E.first_name || '  ' ||  E.last_name AS Treating_Doctor FROM Employee_detailes E , patients P WHERE E.id = P.treating_physician ORDER BY p.last_name"
showPatientDoctors = "SELECT *  FROM patients_doctors"
patientsDiagnosisView = "CREATE VIEW Patients_Diagnosis AS SELECT  P.ID AS Patients_ID  , P.first_name || '  ' ||  P.last_name AS Patients , D.disease , D.disease_detail , D.remarks FROM diagnosis D , patients P WHERE D.id = P.ID ORDER BY p.last_name"
showPatientDiagnosis = "SELECT *  FROM patients_Diagnosis"
patientRange = "SELECT  P.ID AS Patients_ID  , P.first_name || '  ' ||  P.last_name , p.entry_date FROM patients P WHERE p.entry_date BETWEEN SYSDATE-{}"
descP = "SELECT * FROM patients ORDER BY last_name DESC"
ascP = "SELECT * FROM patients ORDER BY last_name ASC"
descEmp = "SELECT * FROM Employee_detailes ORDER BY last_name DESC"
ascEmp = "SELECT * FROM Employee_detailes ORDER BY last_name ASC"
departmentS= "SELECT ID , role_code , department_code , count (*) OVER (PARTITION BY department_code ORDER BY department_code ROWS 10 PRECEDING) department_total FROM staff"
pdocD = "SELECT patients.first_name || '  ' || patients.last_name AS patients_name , employee_detailes.first_name || ' ' || employee_detailes.last_name AS doctor_name , diagnosis.disease FROM patients INNER JOIN employee_detailes ON patients.treating_physician = employee_detailes.id INNER JOIN diagnosis ON patients.id = diagnosis.id"
disStatus = "SELECT  d.disease_detail , count (*) FROM diagnosis d GROUP BY d.disease_detail"
medB = "SELECT * FROM medication_basket WHERE medication_code IN(SELECT medication_code FROM Patient_medication)"
notUsedMeds = "SELECT * FROM medication_basket WHERE (SELECT count (*) FROM Patient_medication WHERE Patient_medication.medication_code = medication_basket.medication_code) = 0"
updateStuff = ""
waitingL = "SELECT *  FROM waitingList"
insWait = "INSERT INTO waitingList (seq, ID ) VALUES (DEPT_SEQ.NEXTVAL,{}"
delWait = "DELETE FROM waitingList WHERE waitingList.ID = {}"
updWait1 = "UPDATE waitingList SET SEQ = {}"
updWait2 = " WHERE ID = {}"
bt = "SELECT d.last_blood_test_date , count (*) OVER ( ORDER BY last_blood_test_date RANGE  BETWEEN 90 PRECEDING AND 0 FOLLOWING  ) new_blood_test FROM diagnosis d"

app = Flask(__name__)
Bootstrap(app)

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/home')
def home():
    try:
        username = request.args.get('username', type=str)
        password = request.args.get('Password', type=str)
        bla = "SELECT * FROM all_users WHERE username = {}".format("username")
        users = {}
        users['users'] = []
        users['users'].append({
            'username': username,
            'Password': password
        })

        with open('users.txt', 'w') as outfile:
            json.dump(users, outfile)
        cur.execute(bla)
        data = cur.fetchall()
        print(data)
        if data:
            connection = cx_Oracle.connect(username, password, db_connect)
            print(connection)
            return render_template('home.html')
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        if error.code == 1017:
            print('Please check your credentials.')
            return render_template('check.html')

        # sys.exit()?
        else:
            print('Database connection error: %s'.format(e))
            return render_template("404.html")


@app.route('/check')
def check():
    return render_template('check.html')


@app.route('/patientsAndDoctors')
def patientsAndDoctors():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    #cur.execute(patientsDoctorsView)
    cur.execute(showPatientDoctors)
    data = cur.fetchall()
    return render_template('patientsAndDoctors.html' , data = data)


@app.route('/patientsAndDiagnosis')
def patientsAndDiagnosis():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    #cur.execute(showPatientDiagnosis)
    cur.execute(showPatientDiagnosis)
    data = cur.fetchall()
    return render_template('patientsAndDiagnosis.html' , data = data)


@app.route('/patientsduring3Month')
def patientduring3Month():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    range =request.args.get('range', type=int)
    print(range)
    query = patientRange .format(range) + " AND SYSDATE"
    print(query)
    cur.execute(query)
    data = cur.fetchall()
    return render_template('patientsduring3Month.html' , data = data)

@app.route('/patientDesc')
def patientDesc():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(descP)
    data = cur.fetchall()
    return render_template('patientDesc.html', data = data)


@app.route('/patientAsc')
def patientAsc():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(ascP)
    data = cur.fetchall()
    return render_template('patientAsc.html', data = data)


@app.route('/employeeDesc')
def employeeDesc():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(descEmp)
    data = cur.fetchall()
    return render_template('employeeDesc.html', data = data)


@app.route('/employeeAsc')
def employeeAsc():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(ascEmp)
    data = cur.fetchall()
    return render_template('employeeAsc.html', data = data)


@app.route('/departmentStuff')
def departmentStuff():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(departmentS)
    data = cur.fetchall()
    return render_template('departmentStuff.html', data = data)


@app.route('/patDocDes')
def patDocDes():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(pdocD)
    data = cur.fetchall()
    return render_template('patDocDes.html', data = data)


@app.route('/diseasesStatus')
def diseasesStatus():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(disStatus)
    data = cur.fetchall()
    return render_template('diseasesStatus.html', data = data)


@app.route('/medicationbasket')
def medicationbasket():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(medB)
    data = cur.fetchall()
    return render_template('medicationbasket.html', data = data)


@app.route('/notUsedMedicatons')
def notUsedMedicatons():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(notUsedMeds)
    data = cur.fetchall()
    return render_template('notUsedMedicatons.html', data = data)


@app.route('/updateStuffTable')
def updateStuffTable():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(updateStuff)
    data = cur.fetchall()
    return render_template('updateStuffTable.html', data = data)

@app.route('/findPatient')
def findPatient():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    id = request.args.get('ID', type=int)
    data = cur.callfunc('patients_manager.one_patient' , str , [id])
    return render_template('findPatient.html' , data = data)

@app.route('/listPatient')
def listPatient():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.callproc('patients_manager.list_patients')
    return render_template('listPatient.html')

@app.route('/sumTotEmp')
def sumTotEmp():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    depCode = request.args.get('depCode', type=int)
    result = cur.callfunc('tot_employees' , str , [depCode])
    return render_template('sumTotEmp.html' , data = result)

@app.route('/witingLChange')
def witingLChange():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(waitingL)
    data = cur.fetchall()
    return render_template('witingLChange.html' , data = data)

@app.route('/autocommit')
def autocommit():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    cur = connection.cursor()

    connection.autocommit = True
    cur.execute(waitingL)
    data = cur.fetchall()
    return render_template('witingLChange.html' , data = data)

@app.route('/commit')
def commit():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    connection.commit()
    cur.execute(waitingL)
    data = cur.fetchall()
    return render_template('witingLChange.html' , data = data)

@app.route('/insertP')
def insertP():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    id = request.args.get('IDi', type=int)
    query = insWait .format(id) + " ) "
    cur.execute(query)
    connection.commit()
    cur.execute(waitingL)
    data = cur.fetchall()
    return render_template('witingLChange.html' , data = data)

@app.route('/deleteP')
def deleteP():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    id = request.args.get('IDd', type=int)
    query = delWait .format(id)
    cur.execute(query)
    cur.execute(waitingL)
    data = cur.fetchall()
    return render_template('witingLChange.html' , data = data)

@app.route('/UpdateP')
def UpdateP():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    id = request.args.get('IDu', type=int)
    seq = request.args.get('SEQ', type=int)
    query = updWait1.format(seq) + updWait2.format(id)
    print(query)
    cur.execute(query)
    cur.execute(waitingL)
    data = cur.fetchall()
    return render_template('witingLChange.html' , data = data)

@app.route('/rollback')
def rollback():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    connection.rollback()
    cur.execute(waitingL)
    data = cur.fetchall()
    return render_template('witingLChange.html' , data = data)

@app.route('/bloodeTeststat')
def bloodeTeststat():
    with open('users.txt') as json_file:
        users = json.load(json_file)
        for p in users['users']:
            userN = p['username']
            passw = p['Password']
    connection = cx_Oracle.connect(userN,passw,db_connect)
    print(connection)
    cur = connection.cursor()

    cur.execute(bt)
    data = cur.fetchall()
    return render_template('bloodeTeststat.html' , data = data)






if __name__ == '__main__':
    app.run(debug=True,host='127.0.0.1', port=5000)

