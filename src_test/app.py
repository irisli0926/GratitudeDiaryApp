import json
from db import db
from flask import Flask, request
from db import User
from db import Entry
from db import GratitudeMessage


app = Flask(__name__)
db_filename = "todo.db"


app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True


# initialize app
db.init_app(app)
with app.app_context():
   db.create_all()


# generalized response formats
def success_response(data, code=200):
   return json.dumps({"success": True, "data": data}), code


def failure_response(message, code=404):
   return json.dumps({"success": False, "error": message}), code


# your routes here
@app.route("/api/users/")
def get_users():
   users = [u.serialize() for u in User.query.all()]
   return success_response(users)


# create user
@app.route("/api/users/", methods=["POST"])
def create_task():
   body = json.loads(request.data)
   new_user = User(
       username=body.get('username'),
       email=body.get('email')
   )
   db.session.add(new_user)
   db.session.commit()
   return success_response(new_user.serialize(), 201)


# delete user
@app.route("/api/users/<int:id>/", methods=["DELETE"])
def delete_course(id):
   task = User.query.filter_by(id=id).first()
   if task is None:
       return failure_response("User not found!")
   db.session.delete(task)
   db.session.commit()
   return success_response(task.serialize())


# get user by id
@app.route("/api/users/<int:id>/")
def get_course(id):
   task = User.query.filter_by(id=id).first()
   if task is None:
       return failure_response("User not found!")
   return success_response(task.serialize())