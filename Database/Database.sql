CREATE TABLE Workout (
	date DATE NOT NULL,
	duration INT NOT NULL,
	weather VARCHAR(100),
	temperature VARCHAR(100),
	spectators INT NULL,
	form INT NULL,
	performance INT NULL,
	note VARCHAR(100),
    	PRIMARY KEY(date));

CREATE TABLE exercise (
	exerciseID INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100),
	description VARCHAR(100),
	PRIMARY KEY(exerciseID));

CREATE TABLE groups (
	name VARCHAR(100),
	PRIMARY KEY(name));

CREATE TABLE Checklist (
	date DATE NOT NULL,
	exerciseID INT NOT NULL,
   	load INT NULL,
	totSets INT NULL,
	totRepetitions INT NULL,
	distance INT NULL,
	duration INT NULL,
	FOREIGN KEY (date) REFERENCES Workout(date)
	ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (exerciseID) REFERENCES exercise(exerciseID)
	ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE goal (
	exerciseID INT NOT NULL,
	creationDate DATE NOT NULL,
	load INT NULL,
	totSets INT NULL,
	totRepetitions INT NULL,
	distance INT NULL,
	duration INT NULL,
	achieved BOOLEAN,
	achievedDate DATE,
	PRIMARY KEY (exerciseID, creationDate),
	FOREIGN KEY (exerciseID) REFERENCES exercise(exerciseID)
	ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE ExerciseReplacement (
	replacementID INT NOT NULL,
	replacementsID INT NOT NULL,
	FOREIGN KEY (replacementID) REFERENCES exercise(exerciseID),
	FOREIGN KEY (replacementsID) REFERENCES exercise(exerciseID));

CREATE TABLE GroupCategories (
	nameAlfaGroup VARCHAR(30),
	nameBetaGroup VARCHAR(30),
	FOREIGN KEY (nameAlfaGroup) REFERENCES groups(name)
	ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nameBetaGroup) REFERENCES groups(name)
    	ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IncludedIn (
	exerciseID INT NOT NULL,
	groupName VARCHAR(100),
	FOREIGN KEY (exerciseID) REFERENCES exercise(exerciseID)
	ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (groupName) REFERENCES groups(name)
	ON UPDATE CASCADE ON DELETE CASCADE);