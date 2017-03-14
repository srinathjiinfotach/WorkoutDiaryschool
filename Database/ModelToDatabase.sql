CREATE TABLE Exercise(
	exerciseID	INT		NOT NULL	PRIMARY KEY,
	exerciseName	VARCHAR(30)	NOT NULL,
	description	TEXT		NOT NULL,
	totRepetitions	INT,
	totSets		INT,
	type		VARCHAR(15),
	load		INT,
	distance	VARCHAR(10),
	duration	VARCHAR(10));

CREATE TABLE Goal(
	goalID		INT		NOT NULL	PRIMARY KEY,
	creationDate	TIMESTAMP	NOT NULL,
	achievedDate	TIMESTAMP	NOT NULL,
	exerciseID	INT(10)		NOT NULL	FOREIGN KEY REFERENCES Exercise);

CREATE TABLE GroupCategories(
	groupID		INT		NOT NULL	PRIMARY KEY,
	groupName	VARCHAR(30)	NOT NULL,
	exerciseID	INT(10)		NOT NULL	FOREIGN KEY REFERENCES Exercise);

CREATE TABLE ExerciseReplacement(
	replacementID	INT		NOT NULL	PRIMARY KEY,
	exerciseID	INT(10)		NOT NULL	FOREIGN KEY REFERENCES Exercise);

CREATE TABLE ResultLog(
	goalPeriod	VARCHAR(15)	NOT NULL	PRIMARY KEY,
	period		TIMESTAMP,
	bestResult	VARCHAR(15);

CREATE TABLE Results(
	resultID	INT		NOT NULL	PRIMARY KEY,
	result		VARCHAR(15),
	period		TIMESTAMP	NOT NULL,
	workoutID	INT		NOT NULL	FOREIGN KEY REFERENCES Workout,
	exerciseID	INT(10)		NOT NULL	FOREIGN KEY REFERENCES Exercise);

CREATE TABLE ExerciseTemplate(
	name		VARCHAR(20)	NOT NULL	PRIMARY KEY,
	locationFolder	VARCHAR(30)	NOT NULL,
	exerciseID	INT(10)		NOT NULL	FOREIGN KEY REFERENCES Exercise);

CREATE TABLE Workout(
	workoutID	INT		NOT NULL	PRIMARY KEY,
	date		DATETIME	NOT NULL,
	timeStarted	TIMESTAMP	NOT NULL,
	duration	TIMESTAMP	NOT NULL,
	lvlOfPerformance	INT	NOT NULL,
	note		text,
	weatherConditions	VARCHAR(20),
	temperature	INT,
	humidity	INT,
	ventilation	VARCHAR(10),
	spectators	INT);

CREATE TABLE PulseAndGPS(
	measureID	INT		NOT NULL	PRIMARY KEY,
	period		TIMESTAMP	NOT NULL,
	pulse		INT,
	longitude	GEOGRAPHY,
	latitude	GEOGRAPHY,
	altitude	GEOGRAPHY,
	exerciseID	INT(10)		NOT NULL	FOREIGN KEY REFERENCES Exercise);


