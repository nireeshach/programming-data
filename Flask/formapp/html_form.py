from flask import Flask, render_template, request

app = Flask(__name__)


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/signin")
def signin():
    return render_template("signin.html")


@app.route("/info")
def info():
    first = request.args.get("first")
    last = request.args.get("last")
    return render_template("info.html", first=first, last=last)
