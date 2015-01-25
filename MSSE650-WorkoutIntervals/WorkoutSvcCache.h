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

- (Workout *) createWorkout: (Workout *)workout;
- (NSMutableArray *) retrieveAllWorkout;
- (Workout *) updateWorkout: (Workout *)workout;
- (Workout *) deleteWorkout: (Workout *)workout;

@end
