from pprint import pformat
import os
import json


import requests
from flask import Flask, render_template, request, flash, redirect
from flask_debugtoolbar import DebugToolbarExtension



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
            venue_id = find_event_address(event['venue_id'])
            description = event['description']
            for key in description:
                if key == 'text':
                    description = description[key]
            category_id = event['category_id']
            event_id = event['id']
            results.append({'name': name, 'url': url, 'category_id': category_id, 'venue_id': venue_id, 'description': description, 'id': event_id})
    # If there was an error (status code between 400 and 600)
    else:
        print 'no go'
    
    return results


#I still need to figure out how to display this information
#WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP
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

##I still need to figure out how to display this information
#WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP
   