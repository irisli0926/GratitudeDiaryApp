import json 
from db import db
from flask import Flask, request
from db import Entry
from db import User
# from db import Assignment
# from db import User

app = Flask(__name__)
db_filename = "cms.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

# initialize app
db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code

def failure_response(message, code=404):
    return json.dumps({"error": message}), code


# your routes here
@app.route("/api/users/")
def get_users():
    courses = [t.serialize() for t in User.query.all()]
    return success_response({"users": courses})

@app.route("/api/users/", methods=["POST"])
def create_task():
   body = json.loads(request.data)
   new_user = User(
       name=body.get('name'),
       username=body.get('username'),
       image=body.get('image')
   )
   db.session.add(new_user)
   db.session.commit()
   return success_response(new_user.serialize(), 201)

# get user by id
@app.route("/api/users/<int:id>/")
def get_course(id):
   task = User.query.filter_by(id=id).first()
   if task is None:
       return failure_response("User not found!")
   return success_response(task.serialize())

# delete user
@app.route("/api/users/<int:id>/", methods=["DELETE"])
def delete_course(id):
   task = User.query.filter_by(id=id).first()
   if task is None:
       return failure_response("User not found!")
   db.session.delete(task)
   db.session.commit()
   return success_response(task.serialize())

@app.route("/api/users/<int:id>/entry", methods=["POST"])
def create_entry(id):
    body = json.loads(request.data)
    new_user = Entry(
       text=body.get('text'),
    #    timestamp=body.get('text'),
       user_id= id
   )
    db.session.add(new_user)
    db.session.commit()
    return success_response(new_user.serialize(), 201)

@app.route("/api/users/<int:id>/entry")
def get_entries(id):
    entry = [t.serialize() for t in Entry.query.all()]
    return success_response({"entries": entry})

# get entry by id
@app.route("/api/entry/<int:id>")
def get_entry(id):
   task = Entry.query.filter_by(id=id).first()
   if task is None:
       return failure_response("Entry not found!")
   return success_response(task.serialize())

# get friends 
@app.route("/api/users/<int:id>/friends")
def get_friends(id):
    task = User.query.filter_by(id=id).first()
    if task is None:
       return failure_response("User not found!")
    return success_response(task.friends_serialize())

@app.route("/api/users/<int:id>/friends/<int:friend_id>", methods=["POST"])
def add_friend(id, friend_id):
    user = User.query.filter_by(id=id).first()
    friend = User.query.filter_by(id=friend_id).first()
    if user is None or friend is None:
       return failure_response("User not found!")
    user.add_friend(friend)
    return success_response("yay you have friends!")

@app.route("/api/users/<int:id>/friends/<int:friend_id>", methods=["DELETE"])
def add_friend(id, friend_id):
    user = User.query.filter_by(id=id).first()
    friend = User.query.filter_by(id=friend_id).first()
    if user is None or friend is None:
       return failure_response("User not found!")
    user.delete_friend(friend)
    return success_response("less friends!")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
