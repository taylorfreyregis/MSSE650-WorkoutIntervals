//
//  WorkoutDatabase.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WorkoutDatabaseManager.h"
#import "Constants.h"

// Since I plan on using the same database for two separate models, I've made a singleton access for it.
@implementation WorkoutDatabaseManager

static WorkoutDatabaseManager* manager;

//Create Singleton instance of the database. I like this approach better than the other
+(WorkoutDatabaseManager *)manager {
    if (manager == nil) {
        manager = [[WorkoutDatabaseManager alloc] init];
    }
    return manager;
}

-(id) init{
    if (self = [super init]) {
        NSString *sqliteDb = [[NSBundle mainBundle] pathForResource:DATABASE_NAME ofType:@"sqlite3"];
        
        if (sqlite3_open([sqliteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

-(void) closeDatabase {
    sqlite3_close(_database);
}

@end
