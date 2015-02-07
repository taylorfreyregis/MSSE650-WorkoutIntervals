//
//  WorkoutSvcCache.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutSvc.h"

@interface WorkoutSvcCache : NSObject <WorkoutSvc>

+ (id) workoutSvcCacheSingleton;

- (Workout *) createWorkout: (Workout *)workout;
- (NSMutableArray *) retrieveAllWorkouts;
- (Workout *) updateWorkout: (Workout *)workout;
- (Workout *) deleteWorkout: (Workout *)workout;

@end
