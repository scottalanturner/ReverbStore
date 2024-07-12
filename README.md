
# Reverb Ecommerce Store

Reverb Store is a stripped-down ecommerce storefront based on the popular [Reverb](https://reverb.com) musical instrument marketplace. Reverb is similar to eBay, except it specializes in music instruments.

This project was for a database class as part of my Masters in Data Science degree. I've built a lot of ecommerce sites, many from the ground up. They are all basically the same under the hood, including off the shelf products like Woo-Commerce and Shopify.

This particular project was focused on using advanced SQL functions, rather than having a functioning store. While there are transactions and triggers for data consistency, there is no credit card verification from Stripe, or transactional email notifications for order fullfilment, or messaging, or anything very cool. It's a simple foundation that could be built on.

## Getting Started

The MVC architecture was done with Flask. I've never used Flask before this. If you know MVC and how web frameworks work, Flask is just like any other one. It takes no time to pick up.

I initially started this project with Django, another web framework. Django is an ORM. It doesn't do stored procedures, and that is a problem for me. I've always built things with security in mind, separation of layers, and with maintenance and revisions in mind. If the SQL structure lives in the code (ORM), then you can't change the SQL structure and you're handcuffed from making those changes down the line. Stored procedures are the boxes that prevent that.

Some people argue that putting business logic in stored procedures is worse than putting SQL in code. I disagree. Sure - Django is great for building things fast. But when you have giant Fortune 500 customers that want their own custom implementation of your product, maintaining two (or twenty) codebases is a nightmare. I've had UPS and HP as clients and have been through this. End rant.

# Built With
- Python
- MySQL
- [Flask](https://pypi.org/project/Flask/)

# Mock-ish data

It's a store and since we need something to sell, mock data was initially loaded into the database. Otherwise it would take forever to get enough instruments loaded to do some of the more complex searches. As such, you might see a Gibson guitar with product features that make no sense (24 frets on a guitar that is supposed to have 22 frets). At a minimum, guitars are guitars, and the color description matches the picture. Beyond that, it's likely not a match.