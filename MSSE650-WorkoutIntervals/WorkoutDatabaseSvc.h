//
//  WorkoutDatabaseSvc.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkoutSvc.h"

@interface WorkoutDatabaseSvc : NSObject <WorkoutSvc>

- (NSArray *) retrieveIntervalsForWorkout: (WorkoutModel *) workout;

@end
