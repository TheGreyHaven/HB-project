from unittest import TestCase
from model import connect_to_db, db
from server import app
from flask import session
import os

class FlaskTestsBasic(TestCase):
    """Flask tests."""

    def setUp(self):
        """Stuff to do before every test."""


        #populates test db with sample data
        #pg_dump nightout > database.sql (in terminal)
        os.system("psql testdb < database.sql")


        # Get the Flask test client
        self.client = app.test_client()

        # Show Flask errors that happen during tests
        app.config['TESTING'] = True

        #I want to connect to my test db
        connect_to_db(app, "postgresql:///testdb")

        db.create_all()

    def tearDown(self):
        """do at end of every test"""
        db.session.close()
        db.drop_all()

    def test_index(self):
        """Test homepage page."""

        result = self.client.get("/homepage")
        self.assertIn("Welcome!", result.data)

    def test_search(self):
        """testing the results page"""

        result = self.client.get("/search", query_string={'location': 'San Francisco', 'keyWord': 'music', 'cat_id': 115})
        self.assertIn("Results", result.data)

class FlaskTestsWithSession(TestCase):
    """Flask tests."""

    def setUp(self):
        """Stuff to do before every test."""


        #populates test db with sample data
        #pg_dump nightout > database.sql (in terminal)
        os.system("psql testdb < database.sql")


        # Show Flask errors that happen during tests
        app.config['TESTING'] = True
        app.config['SECRET_KEY'] = 'key'
        # Get the Flask test client
        self.client = app.test_client()

        with self.client as c:
          with c.session_transaction() as sess:
              sess['user_id'] = 1

        #I want to connect to my test db
        connect_to_db(app, "postgresql:///testdb")

        db.create_all()

    def tearDown(self):
        """do at end of every test"""
       
        db.session.close()
        db.drop_all()

    def testUserPage(self):
        """tests the user page """

        result = self.client.get("/users/1")
        self.assertIn("Saved Events:" , result.data)



if __name__ == "__main__":
    import unittest

    #this keeps my test db curent with my working db
    os.system("pg_dump nightout > database.sql")
    unittest.main()



