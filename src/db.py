from flask_sqlalchemy import SQLAlchemy
import datetime

db = SQLAlchemy()

friends = db.Table(
    'friends',
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'), primary_key=True),
    db.Column('friend_id', db.Integer, db.ForeignKey('user.id'), primary_key=True)
)

class User(db.Model):
    """
    User model
    """
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    username = db.Column(db.String, nullable=False)
    image = db.Column(db.String, nullable=False)
    entries = db.relationship('Entry', cascade="delete")
    friends = db.relationship(
        'User',
        secondary=friends,
        primaryjoin=(friends.c.user_id == id),
        secondaryjoin=(friends.c.friend_id == id),
        backref=db.backref('friend_of', lazy='dynamic'),
        lazy='dynamic'
    )

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")
        self.username = kwargs.get("username") 
        self.image = kwargs.get("image") 
        self.friends = []
        # self.courses = kwargs.get("courses") 

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "username": self.username,
            "image": self.image,
            "entries": [a.simple_serialize() for a in self.entries],
            "friends": [a.simple_serialize() for a in self.friends]
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "username": self.username,
            "image": self.image,
            "friends": [a.simple_serialize() for a in self.friends]
        }
    
    def friends_serialize(self):
        return {"friends": [a.simple_serialize() for a in self.friends]}
    
    def add_friend(self, user):
        # if not self.is_friend(user):
        self.friends.append(user)
        user.friends.append(self)

    def remove_friend(self, user):
        # if self.is_friend(user):
        self.friends.remove(user)
        user.friends.remove(self)


class Entry(db.Model):
    """
    Assignment model
    """
    __tablename__ = "entry"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    text = db.Column(db.String, nullable=False)
    # timestamp = db.Column(db.DateTime, default=datetime.datetime.utcnow, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    # course = db.relationship("Course", secondary=assoc_assignment, back_populates='assignments')

    def __init__(self, **kwargs):
        self.text = kwargs.get("text")
        # self.timestamp = datetime.datetime.now().isoformat() 
        self.user_id = kwargs.get("user_id")
        # self.course_id = kwargs.get("course_id", "")

    def serialize(self):
        user = User.query.filter_by(id=self.user_id).first()
        return {
            "id": self.id,
            "text": self.text,
            "timestamp": datetime.datetime.now().isoformat(),
            "user": user.simple_serialize()
            # "course_id": [a.serialize() for a in self.courses]
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "text": self.text,
            "timestamp": datetime.datetime.now().isoformat(),
        }




