import app
import unittest

class FlaskTestCase(unittest.TestCase):

    def setUp(self):
        self.app = app.app.test_client()

    def test_index(self):
        rv = self.app.get('/')
        self.assertEqual(rv.status_code, 200)
        self.assertIn(b'This is the crossword puzzle.', rv.data)

    def test_about(self):
        rv = self.app.get('/about')
        self.assertEqual(rv.status_code, 200)
        self.assertIn(b'This is the about page.', rv.data)

if __name__ == '__main__':
    unittest.main()
