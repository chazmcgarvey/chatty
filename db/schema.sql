
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

