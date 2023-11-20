from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import sqlite3

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = "Users"

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), index=True, unique=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)
    email = db.Column(db.String(120), index=True, unique=True, nullable=False)
    entries = db.relationship('Entry', backref='author', lazy='dynamic')
    messages_sent = db.relationship('GratitudeMessage', foreign_keys='GratitudeMessage.sender_id', backref='sender', lazy='dynamic')
    messages_received = db.relationship('GratitudeMessage', foreign_keys='GratitudeMessage.recipient_id', backref='recipient', lazy='dynamic')
    friends = db.relationship('User', secondary='friends', primaryjoin=(friends.c.user_id == id), secondaryjoin=(friends.c.friend_id == id), backref=db.backref('friends', lazy='dynamic'), lazy='dynamic')

    def __init__(self, **kwargs):
        super(User, self).__init__(**kwargs)
        self.username = kwargs.get('username')
        self.password_hash = kwargs.get('password_hash')
        self.email = kwargs.get('email')

    def serialize(self):
        return {
            "id": self.id,
            "username": self.username,
            "email": self.email,
            "entries": [entry.serialize() for entry in self.entries],
            "messages_sent": [message.serialize() for message in self.messages_sent],
            "messages_received": [message.serialize() for message in self.messages_received],
            "friends": [friend.serialize() for friend in self.friends]
        }

class Entry(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String(500), nullable=False)
    timestamp = db.Column(db.DateTime, server_default=db.func.now(), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

    def __init__(self, **kwargs):
        super(Entry, self).__init__(**kwargs)
        self.text = kwargs.get('text')
        self.user_id = kwargs.get('user_id')

    def serialize(self):
        return {
            "id": self.id,
            "text": self.text,
            "timestamp": self.timestamp.isoformat(),
            "user_id": self.user_id
        }

class GratitudeMessage(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String(500), nullable=False)
    timestamp = db.Column(db.DateTime, server_default=db.func.now(), nullable=False)
    sender_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    recipient_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

    def __init__(self, **kwargs):
        super(GratitudeMessage, self).__init__(**kwargs)
        self.text = kwargs.get('text')
        self.sender_id = kwargs.get('sender_id')
        self.recipient_id = kwargs.get('recipient_id')

    def serialize(self):
        return {
            "id": self.id,
            "text": self.text,
            "timestamp": self.timestamp.isoformat(),
            "sender_id": self.sender_id,
            "recipient_id": self.recipient_id
        }
    
    # def get_message_by_id():
    #     return {

    #     }

friends = db.Table('friends',
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'), primary_key=True),
    db.Column('friend_id', db.Integer, db.ForeignKey('user.id'), primary_key=True)
)
