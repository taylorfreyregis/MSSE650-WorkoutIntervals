sqlite3 WorkoutDatabase.sqlite3

-- Intervals
-- Create Table

CREATE TABLE Intervals (
Id INTEGER PRIMARY KEY AUTOINCREMENT,
Name VARCHAR(50),
Duration INTEGER
);

-- Insert
INSERT INTO Intervals (Name, Duration)
VALUES ("Example Interval", 30);

-- Select all intervals
SELECT Intervals.Id, Intervals.Name, Intervals.Duration
FROM Intervals;
-- WHERE <boolean expression> optional

-- Update Interval
UPDATE Intervals
SET Interval.Name = value, Interval.Duration = value
WHERE Interval.Id = value; --...
-- WHERE <boolean expression> optional

DELETE FROM Intervals
WHERE; -- NOT OPTIONAL! Otherwise will delete all elements...

-- Workouts

CREATE TABLE Workouts (
Id INTEGER PRIMARY KEY AUTOINCREMENT,
Name VARCHAR(50)
);

-- Insert
INSERT INTO Workouts (Name)
VALUES ("Example Workout");

-- Select all intervals
SELECT Workouts.Id, Workouts.Name
FROM Workouts;
-- WHERE <boolean expression> optional

-- Update Interval
UPDATE Workouts
SET field = value; --...
-- WHERE <boolean expression> optional

DELETE FROM Workouts
WHERE; -- NOT OPTIONAL! Otherwise will delete all elements...

-- WorkoutIntervals

CREATE TABLE WorkoutIntervals (
Id INTEGER PRIMARY KEY AUTOINCREMENT,
WorkoutId INTEGER,
IntervalId INTEGER,
IntervalOrder INTEGER,
FOREIGN KEY (WorkoutId) REFERENCES Workouts(Id),
FOREIGN KEY (IntervalId) REFERENCES Intervals(Id)
);

-- Insert
INSERT INTO WorkoutIntervals (WorkoutId, IntervalId, IntervalOrder)
VALUES (1, 1, 0);

-- Select all intervals for a specific workout
SELECT Intervals.Id, Intervals.Name, Intervals.Duration
FROM WorkoutIntervals
INNER JOIN Intervals ON Intervals.Id = WorkoutIntervals.IntervalId
WHERE WorkoutIntervals.WorkoutId = value; -- WorkoutId

-- Update Interval
UPDATE Workouts
SET field = value; --...
-- WHERE <boolean expression> optional

DELETE FROM WorkoutIntervals
WHERE; -- NOT OPTIONAL! Otherwise will delete all elements...