#!/bin/env python3

from http.server import HTTPServer
from http.server import BaseHTTPRequestHandler

class handler(BaseHTTPRequestHandler):
    def do_POST(self):
        self.send_response(200)
        self.end_headers()
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        print('\033[31m' + post_data.decode('utf-8') + '\033[0m')
        self.wfile.write("body".encode())

HTTPServer(('127.0.0.1', 9999), handler).serve_forever()

