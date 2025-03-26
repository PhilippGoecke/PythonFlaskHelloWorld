from flask import Flask

app = Flask(__name__)

@app.route('/')
@app.route('/<name>')
def index(name='World'):
  return 'Hello ' + str(name) + '!'

app.run(host='0.0.0.0', port=5000)
