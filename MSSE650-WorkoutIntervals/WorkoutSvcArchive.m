//
//  WorkoutSvcArchive.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WorkoutSvcArchive.h"

@implementation WorkoutSvcArchive

NSString *filePath;

NSMutableArray *workouts;

# pragma mark Singleton Methods

+ (id) workoutSvcSingleton {
    static WorkoutSvcArchive *workoutSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        workoutSingleton = [[self alloc] init];
    });
    return workoutSingleton;
}

# pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeFromArchive];
    }
    return self;
}

- (void) initializeFromArchive {
    [self getFilePath];
    [self readArchive];
}

- (void) getFilePath {
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
    filePath = [[NSString alloc] initWithString:[documentsDirectoryPath stringByAppendingPathComponent:@"Workouts.archive"]];
}

- (void) readArchive {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        workouts = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        workouts = [[NSMutableArray alloc] init];
    }
}

# pragma mark IntervalSvc Implementation


- (Workout *) createWorkout: (Workout *)workout {
    
    [workouts addObject:workout];
    [self writeArchive];
    return workout;
}

- (NSMutableArray *) retrieveAllWorkouts {
    
    return workouts;
}

- (Workout *) updateWorkout: (Workout *)workout {
    
    int location = (int)[workouts indexOfObject:workout];
    
    [workouts replaceObjectAtIndex:location withObject:workout];
    [self writeArchive];
    return workout;
}

- (Workout *) deleteWorkout: (Workout *)workout {
    
    [workouts removeObject:workout];
    [self writeArchive];
    return workout;
}

# pragma mark - Archiving

- (void) writeArchive {
    [NSKeyedArchiver archiveRootObject:workouts toFile:filePath];
}

@end
