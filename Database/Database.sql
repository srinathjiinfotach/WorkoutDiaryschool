CREATE TABLE Workout (
	date 		DATE 	NOT NULL,
	duration 	INT 	NOT NULL,
	weather 	VARCHAR(30),
	temperature 	INT,
	spectators 	INT,
	form 		INT,
	performance	INT,
	note 		VARCHAR(80),
    	PRIMARY KEY(date));

CREATE TABLE Exercise (
	exerciseID 	INT	NOT NULL AUTO_INCREMENT,
	name VARCHAR(30),
	description VARCHAR(80),
	PRIMARY KEY(exerciseID));

CREATE TABLE Groups (
	name VARCHAR(30),
	PRIMARY KEY(name));

CREATE TABLE Checklist (
	date 		DATE	 NOT NULL,
	exerciseID 	INT	NOT NULL,
   	totLoad 	INT,
	totSets 	INT,
	totRepetitions 	INT,
	distance 	INT,
	duration 	INT,
	FOREIGN KEY (date) REFERENCES Workout(date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (exerciseID) REFERENCES Exercise(exerciseID) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE Goal (
	exerciseID 	INT	NOT NULL,
	creationDate 	DATE 	NOT NULL,
	totLoad 	INT,
	totSets 	INT,
	totRepetitions 	INT,
	distance 	INT,
	duration 	INT,
	achieved 	BOOLEAN,
	achievedDate 	DATE,
	PRIMARY KEY (exerciseID, creationDate),
	FOREIGN KEY (exerciseID) REFERENCES Exercise(exerciseID) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE ExerciseReplacement (
	replacementID 	INT	NOT NULL,
	replacementsID 	INT	NOT NULL,
	FOREIGN KEY (replacementID) REFERENCES Exercise(exerciseID),
	FOREIGN KEY (replacementsID) REFERENCES Exercise(exerciseID));

CREATE TABLE GroupCategories (
	nameAlfaGroup 	VARCHAR(30),
	nameBetaGroup 	VARCHAR(30),
	FOREIGN KEY (nameAlfaGroup) REFERENCES Groups(name) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nameBetaGroup) REFERENCES Groups(name) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IncludedIn (
	exerciseID 	INT 	NOT NULL,
	groupName 	VARCHAR(100),
	FOREIGN KEY (exerciseID) REFERENCES Exercise(exerciseID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (groupName) REFERENCES Groups(name) ON UPDATE CASCADE ON DELETE CASCADE);