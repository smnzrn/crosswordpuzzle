import unittest
from app.app import app  # Assuming your Flask app instance is named `app`

class FlaskTestCase(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_index_page(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        # Add any additional assertions you might need. For instance, checking if certain words or titles are in the response

    def test_about_page(self):
        response = self.app.get('/about')
        self.assertEqual(response.status_code, 200)
        # Again, add any additional assertions that are necessary

if __name__ == '__main__':
    unittest.main()
