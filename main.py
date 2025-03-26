from flask import Flask

app = Flask(__name__)

@app.route('/')
def index(name):
  if not name:
    name = 'World'
  return 'Hello ' + str(name) + '!'

app.run(host='0.0.0.0', port=8001)
