//
//  WorkoutSvc.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutModel.h"

@protocol WorkoutSvc <NSObject>

+ (id) workoutSvcSingleton;

- (WorkoutModel *) createWorkout: (WorkoutModel *)workout;
- (NSMutableArray *) retrieveAllWorkouts;
- (WorkoutModel *) updateWorkout: (WorkoutModel *)workout;
- (WorkoutModel *) deleteWorkout: (WorkoutModel *)workout;

@end
