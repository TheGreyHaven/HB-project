from pprint import pformat
import os
import json


import requests
from flask import Flask, render_template, request, flash, redirect
from flask_debugtoolbar import DebugToolbarExtension

client_id, client_secret = os.environ.get('YELP_Client_ID'), os.environ.get('YELP_Client_Secret')


EVENTBRITE_TOKEN = os.getenv('EVENTBRITE_TOKEN')

EVENTBRITE_URL = "https://www.eventbriteapi.com/v3/"





def find_event(query, location, category_id): 
    """ Find and return event query from Eventbrite api"""
  


    payload = {'q': query,
               'location.address': location,
               'categories': category_id
               }
    
    # For GET requests to Eventbrite's API, the token could also be sent as a
    # URL parameter with the key 'token'
    headers = {'Authorization': 'Bearer ' + EVENTBRITE_TOKEN}

    response = requests.get(EVENTBRITE_URL + "events/search/",
                            params=payload,
                            headers=headers)
    data = response.json()

    # If the response was successful (with a status code of less than 400),
    # use the list of events from the returned JSON
    results = []
    
    if response.ok:
        events = data['events']
        for event in events:
            name = event['name']
            for key in name:
                if key == 'text':
                    name = name[key]
            url = event['url']
            address = find_event_address(event['venue_id'])
            address = address.strip()
            description = event['description']
            for key in description:
                if key == 'text':
                    description = description[key]
                    #I want to clean this up a bit but rstip() 'NoneType' object has no attributrstrip()
                    #description = description.strip()
            category_id = event['category_id']
            event_id = event['id']
            results.append({'name': name, 'url': url, 'category_id': category_id, 'address': address, 'description': description, 'id': event_id})
    # If there was an error (status code between 400 and 600)
    else:
        print 'no go'
    
    return results


#calling on this fnction from find_event()
def find_event_address(venue_id): 
    """ use the venue id to get the address of the event"""

    payload = {'venue_id': venue_id}

    headers = {'Authorization': 'Bearer ' + EVENTBRITE_TOKEN}

    response = requests.get(EVENTBRITE_URL + "venues" + "/" + str(venue_id),
                            params=payload,
                            headers=headers)
    data = response.json()

    

    # If the response was successful (with a status code of less than 400),
    # use the list of events from the returned JSON
  
    if response.ok:
        address = data['address']['localized_address_display']
        return address
            

           


    # If there was an error (status code between 400 and 600)
    else:
        print 'no way'

def find_yelp_restaurants(location):
    """Use yelp Api to find restaurant options"""

    YELP_URL = "https://api.yelp.com/v3/businesses/search"

    # For GET requests to Yelps's API, the token could also be sent as a
    # URL parameter with the key 'token'
    headers = {'Authorization': 'Bearer ' + get_yelp_access_token(client_id, client_secret)}

    # payload = {'location': location }

    payload = {'term': "food", "location": "location", "limit": 3}


    response = requests.get(YELP_URL,
                            params=payload,
                            headers=headers)
    
    data = response.json()

    print data



def get_yelp_access_token(client_id, client_secret):
    """The token is only good for 180 days so here is a function to reget the token eveytime program runs"""
    
    request_url = "https://api.yelp.com/oauth2/token"
    headers = {
        "content-type":"application/x-www-form-urlencoded",
        "cache-control":"no-cache"
    }
    payload = {
        "grant_type": "client_credentials",
        "client_id": client_id,
        "client_secret": client_secret,
    }
    resp = requests.post(request_url, headers=headers, params=payload)
    data = resp.json()
    return data['access_token']



find_yelp_restaurants("800 sutter st, san francisco")


   