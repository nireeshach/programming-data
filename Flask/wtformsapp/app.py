from flask import Flask, render_template, request, url_for, redirect, session, flash
from flask_wtf import FlaskForm
from wtforms import (
    StringField,
    RadioField,
    BooleanField,
    DateTimeField,
    TextAreaField,
    SelectField,
    TextField,
    SubmitField,
)

from wtforms.validators import DataRequired

app = Flask(__name__)

app.config["SECRET_KEY"] = "MYKEY"


class InfoForm(FlaskForm):

    name = StringField("Enter your name", validators=[DataRequired()])
    Nationality = BooleanField("Are you an Indian?")
    Gender = RadioField(
        "Select Gender", choices=[("female", "Female"), ("male", "male")]
    )
    Languages_Known = SelectField(
        "select language you are familiar",
        choices=[
            ("hi", "Hindi"),
            ("eng", "English"),
            ("te", "Telugu"),
            ("tm", "Tamil"),
            ("gu", "Gujarati"),
            ("ben", "Bengali"),
            ("ma", "marati"),
            ("ka", "kanada"),
        ],
    )
    Address = TextAreaField()
    submit = SubmitField("submit")


@app.route("/", methods=["GET", "POST"])
def index():

    form = InfoForm()

    if form.validate_on_submit():

        session["name"] = form.name.data
        session["Nationality"] = form.Nationality.data
        session["Gender"] = form.Gender.data
        session["Languages_known"] = form.Languages_Known.data
        session["Address"] = form.Address.data
        return redirect(url_for("thankyou"))

    return render_template("index.html", form=form)


@app.route("/thankyou")
def thankyou():
    return render_template("thankyou.html")
