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

- (NSMutableArray *) retrieveAllWorkout{
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

@end
