
PRAGMA foreign_keys = ON;

CREATE TABLE room (
	id		INTEGER PRIMARY KEY,
	name		TEXT UNIQUE,
	created		TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE account (
	id		INTEGER PRIMARY KEY,
	username	TEXT UNIQUE,
	password	TEXT NOT NULL,
	status		TEXT DEFAULT 'active',
	current_room	INTEGER REFERENCES room(id)
);

CREATE TABLE message (
	id		INTEGER PRIMARY KEY,
	posted		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	author		INTEGER REFERENCES account(id),
	room		INTEGER REFERENCES room(id),
	content		TEXT
);

INSERT INTO account (username, password) VALUES ('chaz', 'mypass');
INSERT INTO account (username, password) VALUES ('jdoe', 'foobar');

