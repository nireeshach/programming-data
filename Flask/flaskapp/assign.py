from flask import Flask
from flask import render_template

app = Flask(__name__)


@app.route("/data")
def main():

    mylist = ["data_sources", "data_destination"]
    return render_template("basic.html", mylist=mylist)
