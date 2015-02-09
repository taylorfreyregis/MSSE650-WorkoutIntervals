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
    
    int hours, minutes, seconds = 0;
    
    if (durationInSeconds > 0) {
        hours = (int)(durationInSeconds / 3600);
        minutes = (int)((durationInSeconds % 3600) / 60);
        seconds = (int)((durationInSeconds % 3600) % 60);
    }
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}
@end
