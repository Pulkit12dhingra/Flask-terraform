"""Sample unit test for Flask application"""

# test_app.py
import unittest
from app import app


class FlaskAppTestCase(unittest.TestCase):
    def setUp(self):
        """Set up a test client before each test"""
        app.config["TESTING"] = True
        self.client = app.test_client()

    def test_hello_route(self):
        """Test the hello world route"""
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, b"Hello, World from Flask!")


if __name__ == "__main__":
    unittest.main()
