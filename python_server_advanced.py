#unlike the common 'python -m http.server' - this script supports uploads as well

import http.server
import socketserver
import cgi

class SimpleHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        if self.path == '/upload':
            ctype, pdict = cgi.parse_header(self.headers['content-type'])
            if ctype == 'multipart/form-data':
                pdict['boundary'] = bytes(pdict['boundary'], "utf-8")
                fields = cgi.parse_multipart(self.rfile, pdict)
                file_data = fields.get('file')
                file_name = self.headers['filename']
                if file_data and file_name:
                    with open(file_name, "wb") as f:
                        f.write(file_data[0])
                    self.send_response(200)
                    self.end_headers()
                    self.wfile.write(b'File uploaded successfully')
                    return
        self.send_response(400)
        self.end_headers()
        self.wfile.write(b'Bad request')

PORT = 8080
Handler = SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("Serving at port", PORT)
    httpd.serve_forever()