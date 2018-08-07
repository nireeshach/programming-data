import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:////" + os.path.join(
    basedir, "datasqlite"
)
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)
Migrate(app, db)


class DataCatalog(db.Model):

    __tablename__ = "datacatalog"

    id = db.Column(db.Integer, primary_key=True)
    main_data_source_key = db.Column(db.String(50))
    entity = db.Column(db.String(50))
    field = db.Column(db.String(50))
    normalize_type = db.Column(db.String(50))

    def __init__(self, main_data_source_key, entity, field, normalize_type):

        self.main_data_source_key = main_data_source_key
        self.entity = entity
        self.field = field
        self.normalize_type = normalize_type

    def __reper__(self):

        return ("{}, {}, {}").format(
            "self.main_data_source_key", "self.entity", "self.field"
        )
