import unittest
from app import app  # Import your Flask app

class BasicTests(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        
    def test_main_page(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        
    def test_add_task(self):
        response = self.app.post('/add', data=dict(task_name="Test Task"))
        self.assertEqual(response.status_code, 302)  # Redirect status code

if __name__ == '__main__':
    unittest.main()