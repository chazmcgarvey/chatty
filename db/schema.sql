
PRAGMA foreign_keys = ON;

CREATE TABLE account (
	id		INTEGER PRIMARY KEY,
	email		TEXT,
	username	TEXT UNIQUE,
	password	TEXT NOT NULL,
	status		TEXT DEFAULT 'active'
);

CREATE TABLE message (
	id		INTEGER PRIMARY KEY,
	posted		TIMESTAMP,
	author		INTEGER REFERENCES account(id),
	content		TEXT
);

INSERT INTO account (username, password) VALUES ('chaz', 'mypass');
INSERT INTO account (username, password) VALUES ('jdoe', 'foobar');

