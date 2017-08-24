from jinja2 import StrictUndefined

from flask import Flask, render_template, request, flash, redirect, session, jsonify
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, NightOut, User, Event, Category, Restaurant
from eb_helper import find_event, find_event_address, find_yelp_restaurants


app = Flask(__name__)

# Required to use Flask sessions and the debug toolbar
app.secret_key = "ABC"

# Normally, if you use an undefined variable in Jinja2, it fails silently.
# This is horrible. Fix this so that, instead, it raises an error.
app.jinja_env.undefined = StrictUndefined
app.jinja_env.auto_reload = True

@app.route('/homepage')
def sending_categories():
    """Sending categories to the homepage."""
    cats =[]

    for cat, c_id in db.session.query(Category.c_category, Category.c_category_id).all():
        cats.append({'cat': cat, 'c_id': c_id})

    return render_template("homepage.html", cats=cats)


@app.route('/search')
def receiving_search_criteria():
    """receive the search criteria from homepage"""

    location = request.args.get("location")
    query = request.args.get("keyWord")
    category_id = request.args.get("cat_id")
    
    results = find_event(query, location, category_id)


    return render_template("results.html", results=results)
        

@app.route('/save_event.json', methods=['POST'])
def saving_event_results():
    """save a specific event to the database"""


    e_name = request.form.get('name')
    e_link = request.form.get('url')
    e_description = request.form.get('description')
    e_catergory_id = request.form.get('category_id')
    e_location = request.form.get('address')
    
    new_event = Event(e_name=e_name, e_link=e_link, e_description=e_description, e_catergory_id=e_catergory_id, 
        e_location=e_location)

    db.session.add(new_event)
    #commit() is a two way interaction. Sends event info to my db and can return the event_id. 
    db.session.commit()
    
    user_id = session.get("user_id")
    new_no_table = NightOut(user_id=user_id, event_id=new_event.event_id)

    db.session.add(new_no_table)
    db.session.commit()

    return jsonify({"sucess": True})


@app.route('/registration')
def registration_form():
    """Show registration form"""

    return render_template("registration.html")


@app.route('/registration', methods=['POST'])
def register_process():
    """Process registration."""

    # Get form variables
    email = request.form["email"]
    password = request.form["password"]

    new_user = User(email=email, password=password)

    db.session.add(new_user)
    db.session.commit()

    return redirect("homepage")


@app.route('/login', methods=['GET'])
def login_form():
    """Show login form."""

    return render_template("login.html")

@app.route("/users/<int:user_id>")
def user_detail(user_id):
    """Show users saved events."""
    current_user = session.get("user_id")

    saved_nights = db.session.query(NightOut).filter(NightOut.user_id == current_user).all()
    
    user = User.query.get(user_id)
    return render_template("user.html", user=user, saved_nights=saved_nights)


@app.route('/login', methods=['POST'])
def login_process():
    """Process login."""

    # Get form variables
    email = request.form["email"]
    password = request.form["password"]

    user = User.query.filter_by(email=email).first()

    if not user:
        return redirect("/login")

    if user.password != password:
        return redirect("/login")

    session["user_id"] = user.user_id

    return redirect("/users/%s" % user.user_id)


@app.route('/restaurants')
def return_restaurants():
    requested_address = request.args.get('address')
    print "The Address is: "
    print requested_address
    yelp_restaurants = find_yelp_restaurants(requested_address)
    print('*' * 80)
    print('*' * 80)
    print(yelp_restaurants)
    print('*' * 80)
    print('*' * 80)
    return jsonify(yelp_restaurants) 

@app.route('/save_restaurant.json', methods=['POST'])
def saving_restaurant_results():
    """save a specific restaurant to the database"""

    r_name = request.form.get('name')
    r_location = request.form.get('address')
    r_rating = request.form.get('rating')
    r_price = request.form.get('price')
    nightout_id = request.form.get('nightoutId')
    
    new_restaurant = Restaurant.query.filter_by(r_name=r_name, r_location=r_location).first()

    if not new_restaurant:
        new_restaurant = Restaurant(r_name=r_name, r_rating=r_rating, r_location=r_location, r_price=r_price)

        db.session.add(new_restaurant)
        db.session.commit()
    
    user_id = session.get("user_id")
    nightout = NightOut.query.get(nightout_id)

    #could also put nightout.res_id = new_restaurant.res_id
    nightout.restaurant = new_restaurant

    db.session.commit()



    return jsonify({"sucess": True})


@app.route('/delete_restaurant.json', methods=['POST'])
def deleting_restaurant_results():

    nightout_id = request.form.get('noId')
    nightout = NightOut.query.get(nightout_id)

    nightout.res_id = None 

    db.session.commit()


    return jsonify({"sucess": True})


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")

