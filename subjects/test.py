
import unittest
import json
import requests

class TestLeche(unittest.TestCase):
    def testGetLeche(self):
        items = [{"_id": "12345", "nombre": "leche"}]
        url = 'https://easycompras-api.herokuapp.com/productos'
        params = {'where' : json.dumps({'nombre': 'leche'})}
        producto = requests.get(url, params=params).json()['_items'][0]
        self.assertEqual(items[0]['nombre'], producto['nombre'])

class TestSearch(unittest.TestCase):
    def testGetCarne(self):
        items = [{"_id": "12345", "nombre": "carne de cerdo"}]
        url = 'https://easycompras-api.herokuapp.com/productos'
        nombre = "carne"
        params = {'where' : json.dumps({'nombre': {"$regex": f".*{nombre.lower()}.*"}})}
        productos = requests.get(url, params=params).json()['_items']
        self.assertEqual(len(items), len(productos))

if __name__ == '__main__':
    unittest.main()