"""Models and database functions for event and restaurant data."""

from flask_sqlalchemy import SQLAlchemy

# This is the connection to the PostgreSQL database; we're getting
# this through the Flask-SQLAlchemy helper library. On this, we can
# find the `session` object, where we do most of our interactions
# (like committing, etc.)


db = SQLAlchemy()


#composing my ORM

class NightOut(db.Model):
    """Night out association table."""

    __tablename__ = "nightsout"

    no_id = db.Column(db.Integer,
                      autoincrement=True,
                      primary_key=True)
    user_id = db.Column(db.Integer, 
                        db.ForeignKey('users.user_id'),
                        nullable=False)
    event_id = db.Column(db.Integer, 
                        db.ForeignKey('events.event_id'),
                        nullable=False)
    res_id = db.Column(db.Integer, 
                        db.ForeignKey('restaurants.res_id'))
    

    event = db.relationship("Event", backref="nightsout")
    restaurant = db.relationship("Restaurant", backref="nightsout")

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<NightOut no_id=%s user_id=%s event_id=%s res_id=%s>" % (self.no_id,
                                                                         self.user_id,
                                                                         self.event_id,
                                                                         self.res_id)

class User(db.Model):
    """users table."""

    __tablename__ = "users"

    user_id = db.Column(db.Integer,
                        autoincrement=True,
                        primary_key=True)
    password = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(20), nullable=False)

    nightsout = db.relationship("NightOut", backref="users")

    

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<User user_id=%s password=%s email=%s>" % (self.user_id,
                                                           self.password,
                                                           self.email)

class Category(db.Model):
    """categories table."""

    __tablename__ = "categories"

    
    c_category_id = db.Column(db.Integer, primary_key=True)
    c_category = db.Column(db.String(40))

    
    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Category c_category_id=%s c_category=%s>" % (self.c_category_id,
                                                               self.c_category)


class Event(db.Model):
    """events table."""

    __tablename__ = "events"

    event_id = db.Column(db.Integer,
                        autoincrement=True,
                        primary_key=True)
    e_location = db.Column(db.String(100))
    time = db.Column(db.Integer)
    date = db.Column(db.String(40))
    e_catergory_id = db.Column(db.Integer, db.ForeignKey('categories.c_category_id'))
    e_type = db.Column(db.String(100))
    e_link = db.Column(db.String(200))
    e_description = db.Column(db.Text)
    e_name = db.Column(db.String(200), nullable=False)

    

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Event event_id=%s e_name=%s e_location=%s e_date=%s>" % (self.event_id,
                                                                          self.e_name,
                                                                          self.e_location,
                                                                          self.date)


class Restaurant(db.Model):
    """restaurants table."""

    __tablename__ = "restaurants"

    res_id = db.Column(db.Integer,
                        autoincrement=True,
                        primary_key=True)
    r_location = db.Column(db.String(100), nullable=False)
    r_catergory = db.Column(db.String(40))
    r_link = db.Column(db.String(40))
    r_price = db.Column(db.Integer)
    r_name = db.Column(db.String(40), nullable=False)

    

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Restaurant res_id=%s r_name=%s r_location=%s>" % (self.res_id,
                                                                   self.r_name,
                                                                   self.r_location)
                                                                   

class Invitee(db.Model):
    """invitees table."""

    __tablename__ = "Invitees"

    inv_id = db.Column(db.Integer,
                        autoincrement=True,
                        primary_key=True)
    status = db.Column(db.String(20))
    i_email = db.Column(db.String(40))
    no_id = db.Column(db.Integer, 
                      db.ForeignKey('nightsout.no_id'))

    

    def __repr__(self):
        """Provide helpful representation when printed."""

        return "<Invitee inv_id=%s i_email=%s no_id=%s>" % (self.inv_id,
                                                            self.i_email,
                                                            self.no_id)


#####################################################################
# Helper functions:
def connect_to_db(app, db_uri="postgresql:///nightout"):
    """Connect the database to our Flask app."""

    # Configure to use our PostgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will
    # leave you in a state of being able to work with the database
    # directly.

    from server import app
    connect_to_db(app)
    db.create_all()
    print "Connected to DB."





