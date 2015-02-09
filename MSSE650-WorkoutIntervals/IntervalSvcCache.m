//
//  IntervalSvcCache.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "IntervalSvcCache.h"

@implementation IntervalSvcCache

NSMutableArray *intervals;

#pragma mark Singleton Methods

+ (id) intervalSvcSingleton {
    static IntervalSvcCache *intervalSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intervalSingleton = [[self alloc] init];
    });
    return intervalSingleton;
}

#pragma mark IntervalSvc Implementation

- (id) init {
    if (self = [super init]) {
        intervals = [NSMutableArray array];
        
        // This is only for this static cache, but not something to keep in a future release
        [self createStaticIntervals];
        
        return self;
    }
    return nil;
}

- (Interval *) createInterval: (Interval *)interval {

    [intervals addObject:interval];
    return interval;
}

- (NSMutableArray *) retrieveAllIntervals {
    
    return intervals;
}

- (Interval *) updateInterval: (Interval *)interval {

    //TODO Figure out how to update
    return interval;
}

- (Interval *) deleteInterval: (Interval *)interval {
    
    [intervals removeObject:interval];
    return interval;
}

- (void) createStaticIntervals {
    // Since we don't have web services or anything stored yet, just create static resources for the workouts
    Interval *intervalOne = [[Interval alloc] initWithName:@"60 Seconds" andDuration:60];
    [self createInterval:intervalOne];
    
    Interval *intervalTwo = [[Interval alloc] initWithName:@"90 Seconds" andDuration:90];
    [self createInterval:intervalTwo];
    
    Interval *intervalThree = [[Interval alloc] initWithName:@"3 minutes" andDuration:180];
    [self createInterval:intervalThree];
    
    Interval *intervalFour = [[Interval alloc] initWithName:@"5 minutes" andDuration:300];
    [self createInterval:intervalFour];
}

@end
