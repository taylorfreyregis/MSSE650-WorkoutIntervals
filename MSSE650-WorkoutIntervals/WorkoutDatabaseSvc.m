//
//  WorkoutDatabaseSvc.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WorkoutDatabaseSvc.h"
#import "DatabaseManager.h"
#import "IntervalDatabaseSvc.h"

@implementation WorkoutDatabaseSvc

NSMutableArray *workouts;

#pragma mark - Initialization

+ (id) workoutSvcSingleton {
    static WorkoutDatabaseSvc *workoutSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        workoutSingleton = [[self alloc] init];
    });
    return workoutSingleton;
}

- (id) init {
    if (self = [super init]) {
        workouts = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

#pragma IntervalSvc Implementation

- (WorkoutModel *) createWorkout: (WorkoutModel *)workout {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO Workouts (Name) VALUES (\"%@\")", workout.name];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    // Transactions??
    if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last inserted row.
        if (sqlite3_step(statement) == SQLITE_DONE) {
            workout.ident = (int)sqlite3_last_insert_rowid([DatabaseManager manager].database);
            NSLog(@"Insert completed, id returned: %d", workout.ident);
        } else {
            NSLog(@"Error inserting interval. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    }
    
    for (int i = 0; i < workout.intervals.count; i++) {
        // Create query
        NSString *sqlQueryInner = [NSString stringWithFormat:@"INSERT INTO WorkoutIntervals (WorkoutId, IntervalId, IntervalOrder) VALUES (%d, %d, %d)", workout.ident, ((IntervalModel *)workout.intervals[i]).ident, i];
        sqlite3_stmt *statementInner;
        
        // Prepare and execute query
        // Transactions??
        if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQueryInner UTF8String], -1, &statementInner, nil) == SQLITE_OK) {
            
            // When done, process the last inserted row.
            if (sqlite3_step(statementInner) == SQLITE_DONE) {
                int workoutIntervalId = (int)sqlite3_last_insert_rowid([DatabaseManager manager].database);
                NSLog(@"Insert completed for workout: %d interval: %d intervalOrder: %d workoutInterval %d", workout.ident, ((IntervalModel *)workout.intervals[i]).ident, i, workoutIntervalId);
            } else {
                NSLog(@"Error inserting interval. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
            }
            
            sqlite3_finalize(statementInner);
        }
    }
    return workout;
}

- (NSMutableArray *) retrieveAllWorkouts {
    
    workouts = [[NSMutableArray alloc] init];
    
    // Create Query
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT Workouts.Id, Workouts.Name FROM Workouts;"];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // Iterate through each row
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            // Pull out the values, ceate and assign to new Interval, add to internal array
            int ident = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            WorkoutModel *workout = [[WorkoutModel alloc] initWithId:ident andName:name];
            [workouts addObject:workout];
            
            NSLog(@"Retrieved workout with id: %d", workout.ident);
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Error retrieving intervals. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
    }
    
    for (WorkoutModel *workout in workouts) {
        [self retrieveIntervalsForWorkout:workout];
    }
    
    return workouts;
}

- (WorkoutModel *) retrieveIntervalsForWorkout: (WorkoutModel *) workout {
    
    NSMutableArray *intervalIds = [[NSMutableArray alloc] init];
    // Create Query
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT Intervals.Id FROM Intervals INNER JOIN WorkoutIntervals ON WorkoutIntervals.IntervalId = Intervals.Id WHERE WorkoutIntervals.WorkoutId = %d ORDER BY IntervalOrder ASC;", workout.ident];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // Iterate through each row
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            // Pull out the values, ceate and assign to new Interval, add to internal array
            int ident = sqlite3_column_int(statement, 0);
            [intervalIds addObject:[NSNumber numberWithInt:ident]];
            
            NSLog(@"Retrieved interval with id: %d", ident);
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Error retrieving intervals. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
    }
    
    for (NSNumber *number in intervalIds) {
        [workout addInterval:[[IntervalDatabaseSvc intervalSvcSingleton] retrieveIntervalWithId:[number intValue]]];
    }
    
    return workout;
}

- (WorkoutModel *) updateWorkout: (WorkoutModel *)workout {
    
//    // Create query
//    NSString *sqlQuery = [NSString stringWithFormat:@"UPDATE Intervals SET Interval.Name = \"%@\", Interval.Duration = %d WHERE Interval.Id = %d;", interval.name, interval.duration, interval.ident];
//    sqlite3_stmt *statement;
//    
//    // Prepare and execute query
//    if (sqlite3_prepare_v2([WorkoutDatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
//        
//        // When done, process the last updated row.
//        if (sqlite3_step(statement) == SQLITE_DONE) {
//            NSLog(@"Update completed for %d", interval.ident);
//        } else {
//            NSLog(@"Error inserting interval. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
//        }
//        
//        sqlite3_finalize(statement);
//    }
    return workout;
}

- (WorkoutModel *) deleteWorkout: (WorkoutModel *)workout {
    
    // Create query
//    NSString *sqlQuery = [NSString stringWithFormat:@"DELETE FROM Intervals WHERE Interval.Id = %d;", interval.ident];
//    sqlite3_stmt *statement;
//    
//    // Prepare and execute query
//    if (sqlite3_prepare_v2([WorkoutDatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
//        
//        // When done, process the last deleted row.
//        if (sqlite3_step(statement) == SQLITE_DONE) {
//            NSLog(@"Delete completed for %d", interval.ident);
//        } else {
//            NSLog(@"Error inserting interval. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
//        }
//        
//        sqlite3_finalize(statement);
//    }
    return workout;
}

@end
