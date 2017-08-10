# seed the category information into my model.py events table

# from squalchemy import func

from sqlalchemy import func
from pprint import pformat
import os
import json
from model import Event, db, Category, connect_to_db
from server import app
import requests



EVENTBRITE_TOKEN = os.getenv('EVENTBRITE_TOKEN')

EVENTBRITE_URL = "https://www.eventbriteapi.com/v3/"




def load_catergories():
    """load the caregories and caregory_ids into the event table"""


    headers = {'Authorization': 'Bearer ' + EVENTBRITE_TOKEN}

    response = requests.get(EVENTBRITE_URL + "categories/",
                            headers=headers)
    data = response.json()
    
    events = data['categories']
    for event in events:
        cat_name = event['name']
        cat_id = event['id']
        print cat_name, cat_id

        category = Category(c_category_id=cat_id,
                            c_category=cat_name)
        db.session.add(category)

    db.session.commit()

if __name__ == "__main__":
    
    connect_to_db(app)
    db.create_all()

    load_catergories()





