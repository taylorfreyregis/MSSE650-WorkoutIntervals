//
//  Utilities.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (NSString *)getHumanReadableDuration:(int) durationInSeconds {
    
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    
    if (durationInSeconds > 0) {
        hours = (int)(durationInSeconds / 3600);
        minutes = (int)((durationInSeconds % 3600) / 60);
        seconds = (int)((durationInSeconds % 3600) % 60);
    }
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

+ (int) getDurationForWorkoutModel: (WorkoutModel *) workout {
    
    int duration = 0;
    
    for (IntervalModel *interval in workout.intervals) {
        duration += (int)interval.duration;
    }
    
    return duration;
}

+ (int) getDurationForWorkout: (Workout *) workout {
    
    int duration = 0;
    
    for (Interval *interval in workout.intervals) {
        duration += (int)interval.duration;
    }
    
    return duration;
}
@end
