//
//  Utilities.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Workout.h"
#import "Interval.h"
#import "WorkoutModel.h"
#import "IntervalModel.h"

@interface Utilities : NSObject

+ (NSString *)getHumanReadableDuration:(int) seconds;
+ (int)getDurationForWorkoutModel:(WorkoutModel *)workout;
+ (int)getDurationForWorkout:(Workout *)workout;

@end
