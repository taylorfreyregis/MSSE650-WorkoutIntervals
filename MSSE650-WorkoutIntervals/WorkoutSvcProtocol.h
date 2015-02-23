//
//  WorkoutSvcProtocol.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/22/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Workout.h"

@protocol WorkoutSvcProtocol <NSObject>

+ (id) workoutSvcSingleton;

- (Workout *) createWorkout: (Workout *)workout;
- (NSMutableArray *) retrieveAllWorkouts;
- (Workout *) updateWorkout: (Workout *)workout;
- (Workout *) deleteWorkout: (Workout *)workout;

@end
