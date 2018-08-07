import os
from flask import Flask, render_template, redirect, url_for, session, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from form import AddForm, DelForm
from flask_login import logout_user


######################################
#### SET UP OUR SQLite DATABASE #####
####################################

# This grabs our directory
basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)
# Connects our Flask App to our Database
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///" + os.path.join(
    basedir, "data.sqlite"
)
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

# Add on migration capabilities in order to run terminal commands
Migrate(app, db)

#####################################
####################################
###################################
class DataSource(db.Model):

    __tablename__ = "datasource"

    key = db.Column(db.String(50), primary_key=True)
    name = db.Column(db.String(50))
    remarks = db.Column(db.String(50))

    def __init__(self, key, name, remarks):
        self.key = key
        self.name = name
        self.remarks = remarks

    def __repr__(self):
        return f"{self.key} {self.name}."


class DataCatalog(db.Model):

    __tablename__ = "datacatalog"

    key = db.Column(db.String(50), primary_key=True)
    main_data_source_key = db.Column(db.Text)
    field = db.Column(db.Text)
    entity = db.Column(db.Text)
    normalize_type = db.Column(db.Text)

    def __init__(self, key, main_data_source_key, field, entity, normalize_type):
        self.key = key
        self.main_data_source_key = main_data_source_key
        self.field = field
        self.entity = entity
        self.normalize_type = normalize_type

    def __repr__(self):

        return f"{self.main_data_source_key} {self.key}."


@app.route("/")
def main():
    return render_template("welcome.html")


@app.route("/data", methods=["GET", "POST"])
def index():
    return render_template("catalog.html", catalog=DataCatalog.query.all())


@app.route("/source", methods=["GET", "POST"])
def source():
    return render_template("source.html", source=DataSource.query.all())


@app.route("/add", methods=["GET", "POST"])
def add():

    form = AddForm()

    if form.validate_on_submit():

        key = form.key.data
        main_data_source_key = form.main_data_source_key.data
        entity = form.entity.data
        field = form.field.data
        normalize_type = form.normalize_type.data
        new_data = DataCatalog(key, main_data_source_key, entity, field, normalize_type)
        db.session.add(new_data)
        db.session.commit()
        return redirect(url_for("index"))

    return render_template("add.html", form=form)


@app.route("/deldata", methods=["GET", "POST"])
def deldata():

    form = DelForm()
    if form.validate_on_submit():

        key = form.key.data
        new_data = DataCatalog.query.get(key)
        db.session.delete(new_data)
        db.session.commit()
        return redirect(url_for("index"))

    return render_template("del.html", form=form)


@app.route("/login", methods=["GET", "POST"])
def login():
    error = None
    if request.method == "POST":
        if request.form["username"] != "admin" or request.form["password"] != "admin":
            error = "Invalid Credentials. Please try again."
        else:
            return redirect(url_for("index"))
    return render_template("login.html", error=error)


@app.route("/logout", methods=["GET", "POST"])
def logout():
    logout_user
    return redirect(url_for("main"))
