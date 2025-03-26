from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
  name = request.args.get('name', default = 'World', type = str)
  return 'Hello ' + str(name) + '!'

app.run(host='0.0.0.0', port=5000)
