//
//  WorkoutSvcCache.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WorkoutSvcCache.h"
#import "IntervalSvcCache.h"

@implementation WorkoutSvcCache

NSMutableArray *workouts;

#pragma mark Singleton

+ (id) workoutSvcSingleton {
    static WorkoutSvcCache *workoutSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        workoutSingleton = [[self alloc] init];
    });
    return workoutSingleton;
}

#pragma mark WorkoutSvc Implementation

- (id) init {
    if (self = [super init]) {
        workouts = [NSMutableArray array];
        
        [self createStaticWorkouts];
        return self;
    }
    return nil;
}

- (WorkoutModel *) createWorkout: (WorkoutModel *)workout {
    
    [workouts addObject:workout];
    return workout;
}

- (NSMutableArray *) retrieveAllWorkouts {
    return workouts;
}

- (WorkoutModel *) updateWorkout: (WorkoutModel *)workout {
    
    //TODO Figure out how to update.
    return workout;
}

- (WorkoutModel *) deleteWorkout: (WorkoutModel *)workout {
    
    [workouts removeObject:workout];
    return workout;
}

- (void) createStaticWorkouts {
    
    IntervalSvcCache *intervalCache = [IntervalSvcCache intervalSvcSingleton];
    
    NSArray *intervals = [intervalCache retrieveAllIntervals];
    NSArray *firstWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[0], intervals[1], nil];
    NSArray *secondWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[1], intervals[1], nil];
    NSArray *thirdWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[2], intervals[1], nil];
    NSArray *fourthWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[3], intervals[1], nil];
    NSArray *fifthWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[3], intervals[1], intervals[2], intervals[1], nil];
    
    WorkoutModel *first = [[WorkoutModel alloc]initWithName:@"60 On / 90 Off" andIntervals:firstWorkoutIntervals];
    [self createWorkout:first];
    
    WorkoutModel *second = [[WorkoutModel alloc]initWithName:@"90 On / 90 Off" andIntervals:secondWorkoutIntervals];
    [self createWorkout:second];
    
    WorkoutModel *third = [[WorkoutModel alloc]initWithName:@"3 On / 90 Off" andIntervals:thirdWorkoutIntervals];
    [self createWorkout:third];
    
    WorkoutModel *fourth = [[WorkoutModel alloc]initWithName:@"5 On / 90 Off" andIntervals:fourthWorkoutIntervals];
    [self createWorkout:fourth];
    
    WorkoutModel *fifth = [[WorkoutModel alloc]initWithName:@"5 On / 90 Off / 3 On / 90 Off" andIntervals:fifthWorkoutIntervals];
    [self createWorkout:fifth];
    
}

@end
