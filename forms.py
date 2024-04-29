# forms.py
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, Email, EqualTo

# model for login form used on the login page
class LoginForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])

# forms.py
from wtforms.validators import DataRequired, Email, EqualTo

# model for the one page checkout form. This form is used on the checkout page
# to collect the user's shipping information and credit card information
# this form is using dummy data for the credit card information, and no CC validation is done.
# why? Because there is no Stripe integration, or anything else. This is just a demo.
class OnePageCheckoutForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email()])
    first_name = StringField('First Name', validators=[DataRequired()])
    last_name = StringField('Last Name', validators=[DataRequired()])
    billing_address_street1 = StringField('Shipping Address Street 1', validators=[DataRequired()])
    billing_address_street2 = StringField('Shipping Address Street 2')
    billing_address_city = StringField('Shipping City', validators=[DataRequired()])
    billing_address_stateprovince = StringField('Shipping State/Province', validators=[DataRequired()])
    billing_address_postal_code = StringField('Shipping Postal Code', validators=[DataRequired()])
    billing_address_country = StringField('Shipping Country', validators=[DataRequired()])
    # DUMMY DATA!!!
    credit_card_number = StringField('Credit Card Number', validators=[DataRequired()], default='4111111111111111')
    credit_card_expiration_month = StringField('Expiration Month', validators=[DataRequired()], default='12')
    credit_card_expiration_year = StringField('Expiration Year', validators=[DataRequired()], default='2028')
    credit_card_cvv = StringField('CVV', validators=[DataRequired()], default='123')

# register form model used on the register page
class RegisterForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[
        DataRequired(), EqualTo('confirm_password', message='Passwords must match')
    ])
    confirm_password = PasswordField('Confirm Password')
    first_name = StringField('First Name')
    last_name = StringField('Last Name')
    billing_address_street1 = StringField('Billing Address Street 1')
    billing_address_street2 = StringField('Billing Address Street 2')
    billing_address_city = StringField('Billing Address City')
    billing_address_stateprovince = StringField('Billing Address State/Province')
    billing_address_postal_code = StringField('Billing Address Postal Code')
    billing_address_country = StringField('Billing Address Country')