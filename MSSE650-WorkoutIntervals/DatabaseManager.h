//
//  WorkoutDatabase.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DatabaseManager : NSObject

@property (atomic) sqlite3 *database;

+(DatabaseManager *)manager;

@end
