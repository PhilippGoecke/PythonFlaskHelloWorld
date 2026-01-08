from flask import Flask
from flask import request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
  name = request.args.get('name', default = 'World', type = str)
  import flask
  return 'Hello ' + str(name) + '!<br>(Flask version: ' + flask.__version__ + ')'

if __name__ == "__main__":
  app.run(host='0.0.0.0', port=5000)
