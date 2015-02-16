//
//  IntervalDatabaseSvc.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "IntervalDatabaseSvc.h"
#import "WorkoutDatabaseManager.h"

@implementation IntervalDatabaseSvc

NSMutableArray *intervals;

#pragma mark - Initialization

+ (id) intervalSvcSingleton {
    static IntervalDatabaseSvc *intervalSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intervalSingleton = [[self alloc] init];
    });
    return intervalSingleton;
}

- (id) init {
    if (self = [super init]) {
        intervals = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

#pragma IntervalSvc Implementation

- (Interval *) createInterval: (Interval *)interval {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO Intervals (Name, Duration) VALUES (\"%@\", %d);", interval.name, interval.duration];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([WorkoutDatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last inserted row.
        if (sqlite3_step(statement) == SQLITE_DONE) {
            interval.ident = (int)sqlite3_last_insert_rowid([WorkoutDatabaseManager manager].database);
            NSLog(@"Insert completed, id returned: %d", interval.ident);
        } else {
            NSLog(@"Error inserting interval. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    }
    return interval;
}

- (NSMutableArray *) retrieveAllIntervals {
    
    // Create Query
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT Intervals.Id, Intervals.Name, Intervals.Duration FROM Intervals;"];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([WorkoutDatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // Iterate through each row
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            // Pull out the values, ceate and assign to new Interval, add to internal array
            int ident = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            int duration = (int) sqlite3_column_text(statement, 2);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            Interval *interval = [[Interval alloc] initWithId:ident andName:name andDuration:duration];
            [intervals addObject:interval];
            
            NSLog(@"Retrieved interval with id: %d", interval.ident);
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Error retrieving intervals. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
    }
    return intervals;
}

- (Interval *) updateInterval: (Interval *)interval {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"UPDATE Intervals SET Interval.Name = \"%@\", Interval.Duration = %d WHERE Interval.Id = %d;", interval.name, interval.duration, interval.ident];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([WorkoutDatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last updated row.
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Update completed for %d", interval.ident);
        } else {
            NSLog(@"Error inserting interval. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    }
    return interval;
}

- (Interval *) deleteInterval: (Interval *)interval {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"DELETE FROM Intervals WHERE Interval.Id = %d;", interval.ident];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([WorkoutDatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last deleted row.
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Delete completed for %d", interval.ident);
        } else {
            NSLog(@"Error inserting interval. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    }
    return interval;
}

@end