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

- (id) init {
    if (self = [super init]) {
        intervals = [NSMutableArray array];
        return self;
    }
    return nil;
}

- (Interval *) createInterval: (Interval *)interval {

    [intervals addObject:interval];
    return interval;
}

- (NSMutableArray *) retrieveAllInterval {
    
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

@end
