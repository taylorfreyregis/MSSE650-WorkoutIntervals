//
//  WorkoutSvcCache.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WorkoutSvcCache.h"

@implementation WorkoutSvcCache

NSMutableArray *workouts;

- (id) init {
    if (self = [super init]) {
        workouts = [NSMutableArray array];
        return self;
    }
    return nil;
}

- (Workout *) createWorkout: (Workout *)workout {
    
    [workouts addObject:workout];
    return workout;
}

- (NSMutableArray *) retrieveAllWorkouts {
    return workouts;
}

- (Workout *) updateWorkout: (Workout *)workout {
    
    //TODO Figure out how to update.
    return workout;
}

- (Workout *) deleteWorkout: (Workout *)workout {
    
    [workouts removeObject:workout];
    return workout;
}

- (void) createStaticWorkouts {
    NSArray *intervals = [self createIntervals];
    NSArray *firstWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[0], intervals[1], nil];
    NSArray *secondWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[1], intervals[1], nil];
    NSArray *thirdWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[2], intervals[1], nil];
    NSArray *fourthWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[3], intervals[1], nil];
    NSArray *fifthWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[3], intervals[1], intervals[2], intervals[1], nil];
    
    Workout *first = [[Workout alloc]initWithName:@"60 On / 90 Off" andIntervals:firstWorkoutIntervals];
    Workout *second = [[Workout alloc]initWithName:@"90 On / 90 Off" andIntervals:secondWorkoutIntervals];
    Workout *third = [[Workout alloc]initWithName:@"3 On / 90 Off" andIntervals:thirdWorkoutIntervals];
    Workout *fourth = [[Workout alloc]initWithName:@"5 On / 90 Off" andIntervals:fourthWorkoutIntervals];
    Workout *fifth = [[Workout alloc]initWithName:@"5 On / 90 Off / 3 On / 90 Off" andIntervals:fifthWorkoutIntervals];
    
    return [[NSArray alloc]initWithObjects:first, second, third, fourth, fifth, nil];
}

@end
