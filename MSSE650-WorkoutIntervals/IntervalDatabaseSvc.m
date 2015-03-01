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

- (IntervalModel *) createInterval: (IntervalModel *)interval {
    
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
    
    intervals = [[NSMutableArray alloc] init];
    
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
            int duration = (int) sqlite3_column_int(statement, 2);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            IntervalModel *interval = [[IntervalModel alloc] initWithId:ident andName:name andDuration:duration];
            [intervals addObject:interval];
            
            NSLog(@"Retrieved interval with id: %d", interval.ident);
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Error retrieving intervals. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
    }
    return intervals;
}

- (IntervalModel *)retrieveIntervalWithId:(int) ident {
    
    IntervalModel *interval = nil;
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT Intervals.Id, Intervals.Name, Intervals.Duration FROM Intervals WHERE Intervals.Id = %d;", ident];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([WorkoutDatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last inserted row.
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            // Pull out the values, ceate and assign to new Interval
            int ident = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            int duration = (int) sqlite3_column_int(statement, 2);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            interval = [[IntervalModel alloc] initWithId:ident andName:name andDuration:duration];
        } else {
            NSLog(@"Error inserting interval. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Error retrieving interval. Error: %s", sqlite3_errmsg([WorkoutDatabaseManager manager].database));
    }
    return interval;
}

- (IntervalModel *) updateInterval: (IntervalModel *)interval {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"UPDATE Intervals SET Intervals.Name = \"%@\", Intervals.Duration = %d WHERE Intervals.Id = %d;", interval.name, interval.duration, interval.ident];
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

- (IntervalModel *) deleteInterval: (IntervalModel *)interval {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"DELETE FROM Intervals WHERE Intervals.Id = %d;", interval.ident];
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
