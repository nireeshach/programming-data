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
    IntegerField,
)

from wtforms.validators import DataRequired


class AddForm(FlaskForm):

    key = StringField("key")
    main_data_source_key = StringField("main_data_source_key")
    entity = StringField("entity")
    field = StringField("field")
    normalize_type = StringField("normalize_type")
    submit = SubmitField("Save")


class DelForm(FlaskForm):

    key = StringField("key deleted")
    submit = SubmitField("Delete")
