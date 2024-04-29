"""This module contains all the admin routes for the application."""
from mysql.connector import connect
from flask import current_app as app
from flask import Blueprint, render_template
import sqlparse
from app import db
from sqlalchemy import text

admin = Blueprint('admin', __name__, url_prefix='/admin')

@admin.route('/')
def admin_home():
    """This is the admin home page. It contains common links to all reports."""
    return render_template('admin/admin_home.html')

@admin.route('/category_sales_ranks')
def category_sales_ranks():
    """This function retrieves a bunch of agg stats for category sales."""
    # Query the database system catalog to get the view definition
    result = db.session.execute(text("SELECT view_definition FROM information_schema.views WHERE table_name = 'cat_ranking'"))
    view_definition = result.first()[0]

    # Format the view definition
    formatted_view_definition = sqlparse.format(view_definition, reindent=True, keyword_case='upper')

    try:
        with connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            database=app.config['MYSQL_DB'],
        ) as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute('SELECT * FROM cat_ranking')
                data = cursor.fetchall()
                cursor.close()
   
                return render_template('admin/category_sales_ranks.html', data=data, sql=formatted_view_definition)
    except Exception as e:
        return str(e)
    

@admin.route('/sales_by_us_state')
def sales_by_us_state():
    """This function retrieves and displays the instrument sales by us state."""
    # Query the database system catalog to get the view definition
    result = db.session.execute(text("SELECT view_definition FROM information_schema.views WHERE table_name = 'sales_by_us_state'"))
    view_definition = result.first()[0]

    # Format the view definition
    formatted_view_definition = sqlparse.format(view_definition, reindent=True, keyword_case='upper')

    try:
        with connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            database=app.config['MYSQL_DB'],
        ) as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute('SELECT * FROM sales_by_us_state')
                data = cursor.fetchall()
                cursor.close()
   
                return render_template('admin/sales_by_us_state.html', data=data, sql=formatted_view_definition)
    except Exception as e:
        return str(e)


@admin.route('/total_instrument_sales')
def total_instrument_sales():
    """This function retrieves and displays the instrument sales rolled up by category/brand for the last 90 days."""
    # Query the database system catalog to get the view definition
    result = db.session.execute(text("SELECT view_definition FROM information_schema.views WHERE table_name = 'total_instrument_sales'"))
    view_definition = result.first()[0]

    # Format the view definition
    formatted_view_definition = sqlparse.format(view_definition, reindent=True, keyword_case='upper')

    try:
        with connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            database=app.config['MYSQL_DB'],
        ) as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute('SELECT * FROM total_instrument_sales')
                data = cursor.fetchall()
                cursor.close()
   
                return render_template('admin/total_instrument_sales.html', data=data, sql=formatted_view_definition)
    except Exception as e:
        return str(e)


@admin.route('/product_rank')
def product_rank():
    """This function retrieves and displays the most expensive product per category."""
    # Query the database system catalog to get the view definition
    result = db.session.execute(text("SELECT view_definition FROM information_schema.views WHERE table_name = 'ranked_product_by_price'"))
    view_definition = result.first()[0]

    # Format the view definition
    formatted_view_definition = sqlparse.format(view_definition, reindent=True, keyword_case='upper')

    try:
        with connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            database=app.config['MYSQL_DB'],
        ) as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute('SELECT * FROM ranked_product_by_price')
                data = cursor.fetchall()
                cursor.close()
   
                return render_template('admin/product_rank.html', data=data, sql=formatted_view_definition)
    except Exception as e:
        return str(e)



@admin.route('/seller_rank')
def seller_rank():
    """This function retrieves and displays the seller rank."""
    # Query the database system catalog to get the view definition
    result = db.session.execute(text("SELECT view_definition FROM information_schema.views WHERE table_name = 'reverb_seller_rank'"))
    view_definition = result.first()[0]

    # Format the view definition
    formatted_view_definition = sqlparse.format(view_definition, reindent=True, keyword_case='upper')

    try:
        with connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            database=app.config['MYSQL_DB'],
        ) as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute('SELECT * FROM reverb_seller_rank')
                data = cursor.fetchall()
                cursor.close()
   
                return render_template('admin/seller_rank.html', data=data, sql=formatted_view_definition)
    except Exception as e:
        return str(e)
    
@admin.route('/total_sales_by_seller')
def total_sales_by_seller():
    """This is the most widely used report."""
    # Query the database system catalog to get the view definition
    result = db.session.execute(text("SHOW CREATE PROCEDURE total_sales_by_seller"))
    proc_definition = result.first()

    # Format the view definition
    formatted_proc_definition = sqlparse.format(proc_definition[2], reindent=True, keyword_case='upper')

    try:
        with connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            database=app.config['MYSQL_DB'],
        ) as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.callproc('total_sales_by_seller')
                result_sets = cursor.stored_results()

                # Gets the records from the first result set
                data = next(result_sets).fetchall()
   
                return render_template('admin/total_sales_by_seller.html', data=data, sql=formatted_proc_definition)
    except Exception as e:
        return str(e)
    
# Add more admin routes as needed