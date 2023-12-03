from flask_sqlalchemy import SQLAlchemy
import datetime

db = SQLAlchemy()

# association_table = db.Table("association", db.Model.metadata,
#     db.Column("course_id", db.Integer, db.ForeignKey("course.id")),
#     db.Column("user_id", db.Integer, db.ForeignKey("user.id")),
# )

# new_association_table = db.Table("new_association", db.Model.metadata,
#     db.Column("course_id", db.Integer, db.ForeignKey("course.id")),
#     db.Column("user_id", db.Integer, db.ForeignKey("user.id")),
# )

# assoc_assignment = db.Table("new_association_2", db.Model.metadata,
#     db.Column("course_id", db.Integer, db.ForeignKey("course.id")),
# )

# # your classes here
# class Course(db.Model):
#     """
#     Course model
#     """
#     __tablename__ = "course"
#     id = db.Column(db.Integer, primary_key=True, autoincrement=True)
#     code = db.Column(db.String, nullable=False)
#     name = db.Column(db.String, nullable=False)
#     assignments = db.relationship("Assignment", cascade = "delete")
#     instructors = db.relationship("User", secondary=association_table, back_populates="teaching_courses")
#     students = db.relationship("User", secondary=new_association_table, back_populates="enrolled_courses")
#     #     assignments = db.relationship("Assignment", cascade="delete") 
#     # instructors = db.relationship("User", secondary=association_table)
#     # students = db.relationship("User", secondary=association_table)

#     def __init__(self, **kwargs):
#         self.code = kwargs.get("code")
#         self.name = kwargs.get("name")
#         # self.assignments = kwargs.get("assignments", "") 
#         # self.instructors = kwargs.get("instructors") 
#         # self.students = kwargs.get("students") 

#     def serialize(self):
#         return {
#             "id": self.id,
#             "code": self.code,
#             "name": self.name,
#             "assignments": [a.simple_serialize() for a in self.assignments],
#             "instructors": [a.simple_serialize() for a in self.instructors], 
#             "students": [a.simple_serialize() for a in self.students]
#             # "assignments": [a.simple_serialize() for a in self.assignments],
#             # "instructors": [a.simple_serialize() for a in self.students],
#             # "students": [a.simple_serialize() for a in self.students]
#             # "assignments": [],
#             # "instructors": [],
#             # "students": []
            
#         }
    
#     def simple_serialize(self):
#         return {
#             "id": self.id,
#             "code": self.code,
#             "name": self.name,
#         }

class User(db.Model):
    """
    User model
    """
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    username = db.Column(db.String, nullable=False)
    entries = db.relationship('Entry', cascade="delete")

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")
        self.username = kwargs.get("username") 
        # self.courses = kwargs.get("courses") 

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "username": self.username,
            "entries": [a.simple_serialize() for a in self.entries]
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "username": self.username,
        }

class Entry(db.Model):
    """
    Assignment model
    """
    __tablename__ = "entry"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    text = db.Column(db.String, nullable=False)
    timestamp = db.Column(db.String, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    # course = db.relationship("Course", secondary=assoc_assignment, back_populates='assignments')

    def __init__(self, **kwargs):
        self.text = kwargs.get("text")
        self.timestamp = kwargs.get("timestamp") 
        self.timestamp = datetime.datetime.now().isoformat() 
        self.user_id = kwargs.get("user_id")
        # self.course_id = kwargs.get("course_id", "")

    def serialize(self):
        user = User.query.filter_by(id=self.user_id).first()
        return {
            "id": self.id,
            "text": self.text,
            "timestamp": self.timestamp,
            "user": user.simple_serialize()
            # "course_id": [a.serialize() for a in self.courses]
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "text": self.text,
            "timestamp": self.timestamp,
        }




