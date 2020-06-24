import mysql.connector
from datetime import date, datetime, timedelta

cnx = mysql.connector.connect(
			host="127.0.0.1", database='project',
			user='root',password="student",auth_plugin='mysql_native_password')

cursor = cnx.cursor()

def encrypt(password):
	temp = [ord(i)-96 for i in password]
	mod = 1000000007

	power = 1
	encrypted = 0

	for i in range(len(password)):
		encrypted += (power*temp[i])%mod
		encrypted = encrypted % mod

		power = (power * 26)%mod

	return (encrypted)

def signup(Roll_No,Name,Dob,year_of_study,branch,email,password):
	try:
		query= "INSERT INTO students\
				VALUES (%s,%s,%s,%s,%s,%s);"
		cursor.execute(query,(Roll_No,encrypt(password),Name,Dob,year_of_study,branch))

		query= "INSERT INTO contact_details\
				VALUES (%s,NULL,NULL,%s);"

		cursor.execute(query,(Roll_No,email))
		cnx.commit()
	except mysql.connector.Error as err:
		print(err)


# 1. Get students with a particular skill/Interest:

def get_skill(skill,Roll_No=-1):
	query = "SELECT data.student_id, data.full_name, data.year_of_study, data.branch, contact.telegram_handle, contact.github, contact.email_address\
		FROM \
		(\
		SELECT s.student_id, s.full_name, s.year_of_study, s.branch\
		FROM students s, interests i\
		WHERE i.student_id = s.student_id and i.interest= %s\
		) data \
		LEFT JOIN\
		contact_details contact\
		ON data.student_id = contact.student_id ;"

	cursor.execute(query, (skill,))

	toreturn = []
	for i in list(cursor):
		if(str(i[0])!=Roll_No):
			toreturn.append(i)
	
	return toreturn

# 2. Upload a particular document:

def upload_content(Roll_No,course_no,name_of_content,type_of_doc,link):
	query = "INSERT INTO contents VALUES\
		(null,%s,%s,\
		%s,%s,%s);"

	now = datetime.now()
	created_at = now.strftime("%d-%h-%Y %H:%M:%S")

	cursor.execute(query,(created_at,Roll_No,course_no,name_of_content,type_of_doc,link))

	cnx.commit()

# 3. Show document related to a particular course:

def find_by_course(course):
	query = "SELECT *\
		FROM contents\
		WHERE course_no = %s;"

	cursor.execute(query,(course,))

	toreturn = list(cursor)

	return toreturn


# 4. View admins of all the clubs:

def view_admins():
	query = "SELECT a.student_id, a.name, a.club_id, a.club_name, c.telegram_handle, c.github, c.email_address\
		From admins a\
		LEFT JOIN\
		contact_details c\
		ON a.student_id = c.student_id ;"

	cursor.execute(query)

	toreturn = list(cursor)

	return toreturn


# 5. Update your contact details.

def update_contact(Roll_No,tele,github):
	query= "UPDATE contact_details\
		SET telegram_handle = %s, github = %s\
		WHERE student_id = %s;"

	cursor.execute(query, (tele,github,Roll_No))
	cnx.commit()


# 6. Search for a particular person by his/her roll no.

def search_by_roll(Roll_No):
	query = "SELECT *\
		FROM contents\
		WHERE course_no = %s;"

	cursor.execute(query,(course,))

	toreturn = list(cursor)

	return toreturn	

# 7.	View all interest of a person
# 8.	View all the clubs of a given person

def profile_data(Roll_No):
	query = "SELECT data.student_id, data.full_name, data.date_of_birth ,data.year_of_study,data.branch, contact.telegram_handle, contact.github, contact.email_address\
		FROM\
		(\
		SELECT *\
		FROM students s\
		WHERE s.student_id = %s\
		) data \
		LEFT JOIN\
		contact_details contact\
		ON data.student_id = contact.student_id ;"

	cursor.execute(query,(Roll_No,))

	info = list(list(cursor)[0])

	query = "SELECT interest\
		FROM interests\
		WHERE student_id = %s;"

	cursor.execute(query,(Roll_No,))	

	interests = [i[0] for i in cursor]

	query = "SELECT club_name\
	FROM admins\
	WHERE student_id = %s;"

	cursor.execute(query,(Roll_No,))

	club_admin = [i[0] for i in cursor]
	
	query = "SELECT club_tag\
		FROM members\
		WHERE student_id = %s;"

	cursor.execute(query,(Roll_No,))

	club_member = [i[0] for i in cursor if i[0] not in club_admin]

	return [info,club_admin,club_member,interests]


# 9. Verify the credentials of a user:

def verify_cerdential(Roll_No, password):
	query = "SELECT COUNT(*)\
		FROM students\
		WHERE student_id = %s and password = %s;"

	cursor.execute(query,(Roll_No,encrypt(password)))

	return list(cursor)[0][0]		# 1 for match 0 for mismatch 

# 10. Change Password of a particular user:

def change_pass(Roll_No, password):
	query = "UPDATE students\
		SET\
		password = %s\
		WHERE student_id = %s;"

	cursor.execute(query,(encrypt(password),Roll_No))

	cnx.commit()

""" Interests """

# 1. Number of students for each interest.

def interest_popularity():
	query = "SELECT interests.interest,count(students.student_id) as cnt\
		FROM students,interests\
		WHERE students.student_id = interests.student_id \
		GROUP BY interests.interest\
		ORDER BY cnt DESC;"

	cursor.execute(query)

	toreturn = list(cursor)

	return toreturn

# 2. Number of students with different interests in different branches.

def branch_interest():
	query = "SELECT students.branch,interests.interest,COUNT(students.student_id)\
		FROM students,interests\
		WHERE students.student_id = interests.student_id\
		GROUP BY students.branch,interests.interest;"

	cursor.execute(query)

	toreturn = list(cursor)

	return toreturn

# 3. Suggest clubs based on interests of a student 

def suggest_club(Roll_No):
	query = "SELECT interest\
		FROM interests\
		WHERE student_id = %s;"

	cursor.execute(query,(Roll_No,))

	interests = [i[0] for i in cursor]

	data = {'Dance': ['MadToes'], 'Photography': ['Tasveer'], 'Coding': ['Foobar','d4rkc0de'], 'Fashion':['Muse'], 'Design': ['Meraki' ,'Ink']}

	toreturn = {}

	for interest in interests:
		if(data.get(interest,-1)!=-1):

			toreturn[interest] = data[interest]

	return toreturn

# 4. Suggest materials related to interests.

def suggest_courses(Roll_No):
	query = "SELECT interest\
		FROM interests\
		WHERE student_id = %s;"

	cursor.execute(query,(Roll_No,))

	interests = [i[0] for i in cursor]	

	Dance1 = ["Modern Dance Beginner Course","https://www.udemy.com/course/online-modern-dance-beginner-course/","to move with more body awarness, you will have stronger muscels, you will be more flexible, you will have better coordination"]
	Dance2 = ["Popping dance tutorial | How to get started | Core 4 Basic", "https://www.udemy.com/course/popping-dance-tutorial-core-4-basic/", "understand what is popping dance;Understand the idea of hitting, waving, tutting;Understand the idea of the core 4 system and use it for your training"]

	Photography = ["Photography Masterclass: A Complete Guide to Photography","https://www.udemy.com/course/photography-masterclass-complete-guide-to-photography/","You will know how to take amazing photos that impress your family and friends;You will know how the camera truly works, so you can take better photos using manual settings;You will know how to make money with photography"]

	Coding1 = ["Python and Django Full Stack Web Developer Bootcamp","https://www.udemy.com/course/python-and-django-full-stack-web-developer-bootcamp/","Create a fully functional web site using the Full-Stack with Django 1.11;Learn the power of Python to code out your web applications;Create fantastic landing pages"]
	Coding2 = ["Learn Ethical Hacking From Scratch","https://www.udemy.com/course/learn-ethical-hacking-from-scratch/","Start from 0 up to a high-intermediate level;Hack & secure both WiFi & wired networks;Understand how websites work, how to discover & exploit web application vulnerabilities to hack websites"]

	Design1 = ["Photoshop CS6 Crash Course","https://www.udemy.com/course/photoshop-cs6-crash-course/","Understanding the Basics - goes over how to navigate the interface, basic shortcut keys, adding text, working with images, and other features;Layers - shows you how to combine multiple images, resize them, split them apart, and add in color boxes"]
	Design2 = ["Graphic Design Bootcamp: Part 1","https://www.udemy.com/course/graphic-design-for-beginners/","A clear understanding of how to work with BOTH print and web projects in Photoshop, Illustrator, and InDesign;The skills and confidence to create things like flyers, business cards, web graphics, and more;How to build a skill set that can set you up to be employable in the creative industry as a graphic designer"]

	data = {'Dance':[Dance1,Dance2], 'Photography':[Photography], 'Coding':[Coding1,Coding2], 'Design': [Design1,Design2]}

	for interest in interests:
		if(data.get(interest,-1)!=-1):

			toreturn[interest] = data[interest]

	return toreturn


""" FMS """

# 1. Resolve requests/ complaints from FMS end

def resolve_FMS(request_id,isRequest = False):
	query = "UPDATE FMS_{}\
		SET\
		Status = \"Yes\"\
		WHERE request_id = %s;".format("request" if isRequest else "complaint")

	cursor.execute(query,(request_id,))

	cnx.commit()

# 2. Cancel FMS request

def cancel_FMS(req_Id):
	query = "DELETE FROM FMS_Request\
		WHERE request_ID = %s;"

	cursor.execute(query,(req_Id,))

	cnx.commit()

# 3. Know status about your FMS complaint/request.

def status_FMS(email):
	query = "SELECT request_ID,Phone_Number,Location_ID,\
		Room,Description,Status\
		FROM FMS_Request\
		WHERE Email = %s"

	cursor.execute(query,(email,))

	req = list(cursor)

	query = "SELECT complaint_ID,Phone_Number,Location_ID,\
		Room,Description,Status\
		FROM FMS_complaint\
		WHERE Email = %s"

	cursor.execute(query,(email,))

	comp = list(cursor)

	return [ req , comp ]

# 4. Make a new FMS request\complaint

def new_FMS_req_comp(Name,Email,Phone,Location_ID,Room,Description,isRequest = False):
	query = "INSERT INTO FMS_Request\
		VALUES(NULL,%s,%s,%s,%s,\
		%s,%s,\"No\");".format("request" if isRequest else "complaint")

	cursor.execute(query,(Name,Email,Phone,Location_ID,Room,Description))

	cnx.commit()

""" Queries """

# 1. Number of students for each club

def popular_club():
	query = "SELECT C.club_name, COUNT(M.student_id)\
		FROM members M,clubs_and_societies C \
		WHERE M.club_id = C.club_id\
		GROUP BY M.club_id\
		ORDER BY count(M.student_id) DESC;"

	cursor.execute(query)

	toreturn = list(cursor)
	
	return toreturn

# 2. Select students with a particular tag

def search_Tag(tag):
	query = "SELECT student_id\
		FROM members M\
		WHERE M.club_tag = %s;"

	cursor.execute(query,(tag,))

	toreturn = list(cursor)

	return toreturn

# 3. Add a entry into the calendar:

def insert_to_calender(Roll_No,DateTime,Title,Description,Venue):
	query = "INSERT INTO calender\
		VALUES(NULL,%s,%s,\
		%s,%s,%s);"

	cursor.execute(query,(Roll_No,DateTime,Title,Description,Venue))

	cnx.commit()

# 4. Give all the events of a particular student from his calender on a particular date

def get_events(Roll_No,date):
	query = "SELECT title, descriptions, venue\
		FROM calender C\
		WHERE C.student_id = %s AND Date(C.datex) = %s;"

	cursor.execute(query , (Roll_No,date))

	print(list(cursor))

# 5. Show all the uploaded contents of a particular student

def show_uploads(Roll_No):
	cursor.execute("Drop view if exists contentx;")

	query = "CREATE VIEW contentx as\
		SELECT student_id,created_at,name_of_content,type_of_doc,link_of_doc\
		FROM contents;"

	cursor.execute(query)

	query = "SELECT created_at,name_of_content,type_of_doc,link_of_doc\
		FROM contentx C\
		WHERE C.student_id = %s;"

	cursor.execute(query,(Roll_No,))

	toreturn = list(cursor)

	return toreturn

# 6.  Lists of clubs a particular student have subscribed to:

def show_Subscribed(Roll_No):
	query = "SELECT club_name\
	FROM Subscribers S\
	WHERE student_id = %s;"

	cursor.execute(query,(Roll_No,))

	toreturn = list(cursor)

	return toreturn

# 7. Reviews given to the files uploaded by a particular student:

def reviews_to_me(Roll_No):
	query = "SELECT R.rev_id,R.student_id AS Reviewer,R.rating,R.comments,C.name_of_content,C.student_id as Uploader\
		FROM contents C, reviews R\
		WHERE C.student_id = %s AND R.rev_id = C.con_id;"

	cursor.execute(query,(Roll_No,))

	toreturn = list(cursor)

	return toreturn

# 8. Average ratings of all the contents which at least have 1 rating given to it:-

def avg_rating_all():
	query = "SELECT AVG(R.rating),R.rev_id,C.name_of_content,C.course_no,C.student_id AS Uploader\
		FROM reviews R, contents C\
		WHERE rev_id = con_id\
		GROUP BY R.rev_id\
		ORDER BY AVG(R.rating) DESC;"

	cursor.execute(query)

	toreturn = list(cursor)

	return toreturn

	return 

# 9. Average rating of the contents uploaded by a particular student:-

def avg_rating_my(Roll_No):
	query = "SELECT avg(R.rating),R.rev_id,C.name_of_content,C.course_no,C.student_id as Uploader\
		FROM reviews R, contents C\
		WHERE rev_id = con_id AND C.student_id = %s\
		GROUP BY R.rev_id\
		ORDER BY AVG(R.rating) DESC;"

	cursor.execute(query,(Roll_No,))

	toreturn = list(cursor)

	return toreturn


def close():
	cursor.close()
	cnx.close()

close()