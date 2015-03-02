//
//  ProfileDatabaseSvc.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "ProfileDatabaseSvc.h"
#import "DatabaseManager.h"

@implementation ProfileDatabaseSvc

NSMutableArray *profiles;

#pragma mark - Initialization

+ (id) profileSvcSingleton {
    static ProfileDatabaseSvc *profileSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        profileSingleton = [[self alloc] init];
    });
    return profileSingleton;
}

- (id) init {
    if (self = [super init]) {
        profiles = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}


#pragma IntervalSvc Implementation

- (ProfileModel *) createProfile:(ProfileModel *)profile {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO Profiles (Name, Age) VALUES (\"%@\", %d);", profile.name, profile.age];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last inserted row.
        if (sqlite3_step(statement) == SQLITE_DONE) {
            profile.ident = (int)sqlite3_last_insert_rowid([DatabaseManager manager].database);
            NSLog(@"Insert completed, id returned: %d", profile.ident);
        } else {
            NSLog(@"Error inserting profile. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    }
    return profile;
}

- (NSMutableArray *) retrieveAllProfiles {
    
    profiles = [[NSMutableArray alloc] init];
    
    // Create Query
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT Profiles.Id, Profiles.Name, Profiles.Age FROM Profiles;"];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // Iterate through each row
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            // Pull out the values, ceate and assign to new Interval, add to internal array
            int ident = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            int age = (int) sqlite3_column_int(statement, 2);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            ProfileModel *profile = [[ProfileModel alloc] initWithId:ident andName:name andAge:age];
            [profiles addObject:profile];
            
            NSLog(@"Retrieved profile with id: %d", profile.ident);
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Error retrieving intervals. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
    }
    return profiles;
}

- (ProfileModel *)retrieveProfileWithId:(int) ident {
    
    ProfileModel *profile = nil;
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT Profiles.Id, Profiles.Name, Profiles.Age FROM Profiles WHERE Profiles.Id = %d;", ident];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last inserted row.
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            // Pull out the values, ceate and assign to new Interval
            int ident = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            int age = (int) sqlite3_column_int(statement, 2);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            profile = [[ProfileModel alloc] initWithId:ident andName:name andAge:age];
        } else {
            NSLog(@"Error retrieving profile. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Error retrieving profile. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
    }
    return profile;
}

- (ProfileModel *) updateProfile:(ProfileModel *)profile {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"UPDATE Profiles SET Profiles.Name = \"%@\", Profiles.Age = %d WHERE Profiles.Id = %d;", profile.name, profile.age, profile.ident];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last updated row.
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Update completed for %d", profile.ident);
        } else {
            NSLog(@"Error updating profile. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    }
    return profile;
}

- (ProfileModel *) deleteProfile:(ProfileModel *)profile {
    
    // Create query
    NSString *sqlQuery = [NSString stringWithFormat:@"DELETE FROM Profiles WHERE Profiles.Id = %d;", profile.ident];
    sqlite3_stmt *statement;
    
    // Prepare and execute query
    if (sqlite3_prepare_v2([DatabaseManager manager].database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        // When done, process the last deleted row.
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Delete completed for %d", profile.ident);
        } else {
            NSLog(@"Error deleting profile. Error: %s", sqlite3_errmsg([DatabaseManager manager].database));
        }
        
        sqlite3_finalize(statement);
    }
    return profile;
}


@end
