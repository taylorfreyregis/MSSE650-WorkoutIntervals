//
//  Workout.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "Workout.h"

@implementation Workout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.intervals = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(instancetype) initWithName:(NSString *)name andIntervals:(NSArray *)intervals {
    self = [super init];
    if (self){
        self.name = name;
        self.intervals = [[NSMutableArray alloc] init];
        if (intervals != nil && [intervals count] > 0) {
            [self.intervals addObjectsFromArray:intervals];
        }
        [self calculateDuration];
    }
    return self;
}

- (void) addInterval:(Interval *)interval {
    [self.intervals addObject:interval];
    [self calculateDuration];
}

- (void)calculateDuration {
    _duration = 0;
    for (Interval *interval in self.intervals) {
        NSLog(@"calculating duration: %d, adding interval duration: %d", _duration, interval.duration);
        _duration += interval.duration;
    }
}


@end
