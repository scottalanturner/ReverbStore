from MySQLdb import InternalError
from flask import Flask, current_app, session, flash, redirect, render_template, Blueprint, request, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_mysqldb import MySQL
from passlib.hash import pbkdf2_sha256
from mysql.connector import connect, Error

from forms import LoginForm, OnePageCheckoutForm, RegisterForm  # Import the form class
#from admin import admin


db = SQLAlchemy()
mysql = MySQL()
main = Blueprint('main', __name__)

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'your-secret-key'  # Needed for CSRF protection
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://scott:password@localhost/reverb'
    db.init_app(app)

    # MySQL configurations
    app.config['MYSQL_USER'] = 'scott'
    app.config['MYSQL_PASSWORD'] = 'password'
    app.config['MYSQL_DB'] = 'reverb'
    app.config['MYSQL_HOST'] = 'localhost'
    app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
    mysql = MySQL(app)

    from admin import admin
    app.register_blueprint(admin)
    app.register_blueprint(main)

    return app

if __name__ == '__main__':
    app = create_app()
    

SHIPPING_TYPES = {
    1: 'Free Shipping',
    # Add more shipping types as needed
}


# This route will display the order confirmed page
#it will display the order confirmation message
@main.route('/order-confirmed')
def order_confirmed():
    return render_template('order-confirmed.html')


# This route will display the instrument page
#it will display the details of the instrument
#execute the view to get the instrument details
#fetch the record and pass it to the template
@main.route("/instrument/<int:instrument_id>")
def instrument(instrument_id):
    instrument = None
    instrument_attributes = None

    try:
        with connect(
            host=current_app.config['MYSQL_HOST'],
            user=current_app.config['MYSQL_USER'],
            password=current_app.config['MYSQL_PASSWORD'],
            database=current_app.config['MYSQL_DB'],
        ) as connection:
            # Create a new cursor
            with connection.cursor(dictionary=True) as cursor:
                cursor.callproc('get_instrument_by_id', [instrument_id,])
                result_sets = cursor.stored_results()

                # Get the first result set (instrument details)
                instrument = next(result_sets).fetchone()
                # Translate the shipping_type integer to a text value
                instrument['shipping_type'] = SHIPPING_TYPES.get(instrument['shipping_type'], 'Unknown')

                instrument_attributes = next(result_sets).fetchall()
                cursor.close()

    except Error as e:
        print(e)
        flash('An error occurred while fetching the instrument details. Please try again later.', 'danger')
        return redirect(url_for('main.home'))

    return render_template('instrument.html', record=instrument, attributes=instrument_attributes)



# This route will display the checkout page
#it will display the details of the instrument
#execute the view to get the instrument details
#fetch the record and pass it to the template

@main.route('/checkout/<int:instrument_id>', methods=['GET', 'POST'])
def checkout(instrument_id):
    if 'user_id' not in session:
        flash('You must be logged in to checkout.')
        return redirect(url_for('login'))

    # Connect to the database
    try:
        user = None
        instrument = None
        with connect(
            host=current_app.config['MYSQL_HOST'],
            user=current_app.config['MYSQL_USER'],
            password=current_app.config['MYSQL_PASSWORD'],
            database=current_app.config['MYSQL_DB'],
        ) as connection:
            # Create a new cursor
            with connection.cursor(dictionary=True) as cursor:
                cursor.callproc('get_instrument_by_id', [instrument_id,])
                result_sets = cursor.stored_results()

                # Get the first result set (instrument details)
                instrument = next(result_sets).fetchone()

                # Translate the shipping_type integer to a text value
                instrument['shipping_type'] = SHIPPING_TYPES.get(instrument['shipping_type'], 'Unknown')

                # Call the stored procedure to get the user billing address
                user_id = session['user_id']
                cursor.callproc('select_user_profile', [user_id,])

                # Fetch the user values
                result_sets = cursor.stored_results()

                # Get the first result set (instrument details)
                user = next(result_sets).fetchone() 

                if (user is None):
                    flash('An application error occured. User not found. Please login again and retry your purchase', 'danger')
                    return render_template('error.html')             

                # Validate the form on POST
                if request.method == 'POST':
                    # Process the form
                    # Instantiate the form with the instrument and user values
                    form = OnePageCheckoutForm(request.form)
                    if form.validate():
                        # Prepare the parameters for the stored procedure

                        params = [
                            instrument['instrument_id'],
                            session['user_id'],
                            form.credit_card_number.data,
                            form.credit_card_cvv.data,
                            form.credit_card_expiration_month.data,
                            form.credit_card_expiration_year.data,
                            form.billing_address_street1.data,
                            form.billing_address_street2.data,
                            form.billing_address_city.data,
                            form.billing_address_stateprovince.data,
                            form.billing_address_postal_code.data,
                            form.billing_address_country.data,
                            0.00,  # Tax
                            0.00,  # Shipping cost, not implemented
                            instrument['price'],  # Order total
                            user['email']  # Order email
                        ]

                        # Call the stored procedure
                        cursor.callproc('purchase_instrument', params)
                        result_sets = cursor.stored_results()

                        # Get the result set
                        record = next(result_sets).fetchone()
                        # Get the order_id from the result set
                        order_id = record['order_id']

                        # Commit the transaction
                        connection.commit()

                        receipt = {'order_id': order_id, 
                                'total_price': instrument['price'], 
                                'instrument_name': instrument['instrument_name'],
                                'instrument_price': instrument['price']} #correct. No cart implementation for multiple instrument purchases due to 7 table limit.
                        
                        # Pass the data to the template
                        return render_template('order_confirmed.html', receipt=receipt)

                    # Pass the form to the template
                    return render_template('checkout.html', form=form, instrument=instrument)
                else:
                    # Instantiate the form with the user data
                    form = OnePageCheckoutForm(data=user)
                    # Pass the form to the template for display
                    return render_template('checkout.html', form=form, instrument=instrument)
    
    except InternalError as e:
        flash('Error during processing order: {}'.format(str(e)), 'danger')       
        return render_template('error.html')
            

# This route will display the home page
#it will display the featured instruments
#execute the view to get the featured instruments
#fetch the records and pass them to the template
@main.route("/")
def home():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM get_featured_instruments")
    records = cur.fetchall()
    cur.close()
    return render_template('home.html', records=records)


@main.route("/sales")
def sales():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM get_sales_by_category")
    records = cur.fetchall()
    cur.close()
    return render_template('sales.html', records=records)


@main.route("/search")
def search():
    search_by = request.args.get('by', '')  # Default to empty string if 'by' is not provided
 #   search_val = request.arg.get('val', '')  # Default to empty string if 'val' is not provided
    if search_by == 'frets':
        sql = "SELECT * FROM get_by_frets"
        title = 'Instruments by Frets'
    elif search_by == 'nonwhite_guitar':
        sql = "SELECT * FROM get_nonwhite_guitars"
        title = 'Non-White Guitars'
    elif search_by == 'not_drums':
        sql = "SELECT * FROM get_notdrum_instruments"
        title = 'Non-Drum Instruments'
    elif search_by == 'get_cool_guitars':
        sql = "SELECT * FROM get_cool_guitars"
        title = 'Cool Guitars'
    elif search_by == 'get_expensive_guitars':
        sql = "SELECT * FROM get_expensive_guitars"
        title = 'Guitars from $1,000-$3,000'
    elif search_by == 'category':
        category = request.args.get('cat', '')
        sql = f"CALL get_instruments_by_category('{category}')"
        title = 'Instruments by Category'
    #call given sql and fetch the records
    cur = mysql.connection.cursor()
    cur.execute(sql)
    records = cur.fetchall()
    cur.close()

    return render_template('search.html', records=records, title=title)



@main.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm()
    if form.validate_on_submit():
        # Handle the form submission here
        email = form.email.data
        password = form.password.data
        hash_pass = pbkdf2_sha256.hash(password)
        first_name = form.first_name.data
        last_name = form.last_name.data
        billing_address_street1 = form.billing_address_street1.data
        billing_address_street2 = form.billing_address_street2.data
        billing_address_city = form.billing_address_city.data
        billing_address_stateprovince = form.billing_address_stateprovince.data
        billing_address_postal_code = form.billing_address_postal_code.data
        billing_address_country = form.billing_address_country.data

        # You can now use these variables to create a new user in your database
        cursor = mysql.connection.cursor()
        try:
            cursor.callproc('register_user', [email, hash_pass, first_name, last_name, billing_address_street1, billing_address_street2, billing_address_city, billing_address_stateprovince, billing_address_postal_code, billing_address_country])
            mysql.connection.commit()
        except InternalError as e:
            flash('Error during registration: {}'.format(str(e)))
            return render_template('register.html', form=form)
        finally:
            cursor.close()
        flash('Registration successful.')
    return render_template('main/register.html', form=form)


@main.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        # Handle the form submission here
        email = form.email.data
        password = form.password.data

        cursor = mysql.connection.cursor()
        cursor.callproc('auth_user', [email])
        result = cursor.fetchone()

        if not result:
            flash('Invalid email or password.', 'danger')
            return render_template('login.html', form=form)

        user_id = result['user_id']
        hash_pass2 = result['user_password']
        cursor.close()

        if pbkdf2_sha256.verify(password, hash_pass2):
            session['user_id'] = user_id  # Store the user_id in the session
            session['admin'] = result['is_superuser'] == 1
            flash('Logged in successfully.')
            return redirect(url_for('main.home'))
        else:
            flash('Invalid email or password.')

    return render_template('login.html', form=form)

#log out the user and terminate the session
@main.route('/logout', methods=['GET', 'POST'])
def logout():
    session.pop('user_id', None)
    flash('You have been logged out')
    return redirect(url_for('main.home'))
