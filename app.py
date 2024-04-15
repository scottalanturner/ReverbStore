
from flask import flash, redirect, render_template, url_for
from flask import Flask
from flask_mysqldb import MySQL
from forms import LoginForm  # Import the form class
from werkzeug.security import check_password_hash

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key'  # Needed for CSRF protection


# MySQL configurations
app.config['MYSQL_USER'] = 'scott'
app.config['MYSQL_PASSWORD'] = 'password'
app.config['MYSQL_DB'] = 'reverb'
app.config['MYSQL_HOST'] = 'localhost'

mysql = MySQL(app)


@app.route("/")
def home():
    return render_template('home.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        # Handle the form submission here
        username = form.username.data
        password = form.password.data

        cursor = mysql.connection.cursor()
        cursor.callproc('auth_user', [username])
        result = cursor.fetchone()

        if not result:
            flash('Invalid username or password.')  
            return render_template('login.html', form=form)
        
        user_id, hash_pass2 = result
        cursor.close()
        
        if check_password_hash(hash_pass2, password):
            flash('Logged in successfully.')
            return redirect(url_for('home'))
        else:
            flash('Invalid username or password.')


    return render_template('login.html', form=form)