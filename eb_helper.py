from pprint import pformat
import os
import json


import requests
from flask import Flask, render_template, request, flash, redirect
from flask_debugtoolbar import DebugToolbarExtension



EVENTBRITE_TOKEN = os.getenv('EVENTBRITE_TOKEN')

EVENTBRITE_URL = "https://www.eventbriteapi.com/v3/"


def find_event(query, location): 

    payload = {'q': query,
               'location.address': location
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
  
    if response.ok:
        events = data['events']
        for event in events:
            name = event['name']
            for key in name:
                if key == 'text':
                    name = name[key]
            url = event['url']
            venue_id = event['venue_id']
            description = event['description']
            for key in description:
                if key == 'text':
                    description = description[key]
            category_id = event['category_id']

           

    # If there was an error (status code between 400 and 600)
    else:
        print 'no go'


def find_event_address(venue_id): 

    payload = {'venue_id': venue_id}

    headers = {'Authorization': 'Bearer ' + EVENTBRITE_TOKEN}

    response = requests.get(EVENTBRITE_URL + "events/search/",#change this to venue
                            params=payload,
                            headers=headers)
    data = response.json()

    # If the response was successful (with a status code of less than 400),
    # use the list of events from the returned JSON
  
    if response.ok:
        events = data['events']
        for event in events:
            #check to see if this is what the key is
            address = event['address']
            

           


    # If there was an error (status code between 400 and 600)
    else:
        print 'no go'



   