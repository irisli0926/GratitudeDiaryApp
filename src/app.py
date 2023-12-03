import json 
from db import db
from flask import Flask, request
# from db import Course
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
       username=body.get('username'),
       email=body.get('email')
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

# @app.route("/api/courses/<int:id>/add/", methods=["POST"])
# def add_user(id):
#     task = Course.query.filter_by(id=id).first()
#     if task is None:
#         return failure_response("Course not found!")
#     body = json.loads(request.data)
#     user_id = body.get("user_id")
#     type = body.get("type")

#     user = User.query.filter_by(id=user_id).first()
#     if user is None:
#         return failure_response("User not found!")
#     if type == "instructor":
#         task.instructors.append(user)
#     elif type == "student":
#         task.students.append(user)
#     db.session.commit()
#     return success_response(task.serialize(), 201)

# @app.route("/api/courses/<int:id>/assignment/", methods=["POST"])
# def add_assignment(id):
#     task = Course.query.filter_by(id=id).first()
#     if task is None:
#         return failure_response("Course not found!")
#     body = json.loads(request.data)
#     # title = body.get("title")
#     # due_date = body.get("due_date")

#     new_ass = Assignment(
#        title = body.get("title"), due_date = body.get("due_date")
#     )

#     task.assignments.append(new_ass)
#     db.session.commit()
#     return success_response(new_ass.serialize(), 201)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
