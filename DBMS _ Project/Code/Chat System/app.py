from flask import Flask, render_template, flash, redirect, url_for, session, request, logging
from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from functools import wraps
import os

from wtforms.fields.html5 import EmailField

app = Flask(__name__)
app.secret_key = os.urandom(24)

# Config MySQL
mysql = MySQL()
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'student'
app.config['MYSQL_DB'] = 'chatsystem'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# Initialize the app for use with this MySQL class
mysql.init_app(app)

def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			return f(*args, *kwargs)
		else:
			flash('Unauthorized, Please logged in', 'danger')
			return redirect(url_for('login'))
	return wrap


def not_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			flash('Unauthorized, You logged in', 'danger')
			return redirect(url_for('index'))
		else:
			return f(*args, *kwargs)
	return wrap


@app.route('/')
def index():
	return render_template('home.html')


class LoginForm(Form):    # Create Message Form
	email = StringField('email', [validators.length(min=1)], render_kw={'autofocus': True})


# User Login
@app.route('/login', methods=['GET', 'POST'])
@not_logged_in
def login():
	form = LoginForm(request.form)
	if request.method == 'POST' and form.validate():
		# GEt user form
		email = request.form['email']
		password_candidate = request.form['password']

		# Create cursor
		cur = mysql.connection.cursor()

		# Get user by username
		result = cur.execute("SELECT * FROM users WHERE email=%s", [email])

		if result > 0:
			# Get stored value
			data = cur.fetchone()
			password = data['password']
			uid = data['id']
			name = data['name']

			# Compare password
			if encrypt(password_candidate) == password:
				# passed
				session['logged_in'] = True
				session['uid'] = uid
				session['s_name'] = name
				x = '1'
				cur.execute("UPDATE users SET online=%s WHERE id=%s", (x, uid))
				flash('You are now logged in', 'success')

				return redirect(url_for('index'))

			else:
				flash('Incorrect password', 'danger')
				return render_template('login.html', form=form)

		else:
			flash('Username not found', 'danger')
			# Close connection
			cur.close()
			return render_template('login.html', form=form)
	return render_template('login.html', form=form)


@app.route('/out')
def logout():
	if 'uid' in session:

		# Create cursor
		cur = mysql.connection.cursor()
		uid = session['uid']
		x = '0'
		cur.execute("UPDATE users SET online=%s WHERE id=%s", (x, uid))
		session.clear()
		flash('You are logged out', 'success')
		return redirect(url_for('index'))
	return redirect(url_for('login'))

def encrypt(password):
	temp = [ord(i)-96 for i in password]
	mod = 1000000007

	power = 1
	encrypted = 0

	for i in range(len(password)):
		encrypted += (power*temp[i])%mod
		encrypted = encrypted % mod

		power = (power * 26)%mod

	return str(encrypted)

class MessageForm(Form):    # Create Message Form
	body = StringField('', [validators.length(min=1)], render_kw={'autofocus': True})


@app.route('/chatting/<string:id>', methods=['GET', 'POST'])
def chatting(id):
	if 'uid' in session:
		form = MessageForm(request.form)
		# Create cursor
		cur = mysql.connection.cursor()

		# lid name
		get_result = cur.execute("SELECT * FROM users WHERE id=%s", [id])
		l_data = cur.fetchone()
		if get_result > 0:
			session['name'] = l_data['name']
			uid = session['uid']
			session['lid'] = id

			if request.method == 'POST' and form.validate():
				txt_body = form.body.data
				# Create cursor
				cur = mysql.connection.cursor()
				cur.execute("INSERT INTO messages(body, msg_by, msg_to) VALUES(%s, %s, %s)",
							(txt_body, id, uid))
				# Commit cursor
				mysql.connection.commit()

			# Get users
			cur.execute("SELECT * FROM users")
			users = cur.fetchall()

			# Close Connection
			cur.close()
			return render_template('chat_room.html', users=users, form=form)
		else:
			flash('No permission!', 'danger')
			return redirect(url_for('index'))
	else:
		return redirect(url_for('login'))


@app.route('/chats', methods=['GET', 'POST'])
def chats():
	if 'lid' in session:
		id = session['lid']
		uid = session['uid']
		# Create cursor
		cur = mysql.connection.cursor()
		# Get message
		cur.execute("SELECT * FROM messages WHERE (msg_by=%s AND msg_to=%s) OR (msg_by=%s AND msg_to=%s) "
					"ORDER BY id ASC", (id, uid, uid, id))
		chats = cur.fetchall()
		# Close Connection
		cur.close()
		return render_template('chats.html', chats=chats,)
	return redirect(url_for('login'))


if __name__ == '__main__':
	app.run(debug=True)