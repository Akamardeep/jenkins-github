from flask import Flask
app = Flask(__name__)
print('amardeep')

@app.route("/")
def hello():
    return "Hello Worslda!" 
