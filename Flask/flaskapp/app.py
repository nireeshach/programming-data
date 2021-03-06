from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def hello_world():
    return "<h1>Hello, World!</h1>"


@app.route("/main")
def main():
    return render_template("main.html")


@app.route("/sds/<name>")
def user(name):
    return "<p> {} profile page</p>".format(name[10])


if __name__ == "__main__":
    app.run()
