//
//  Workout.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "Workout.h"

@implementation Workout

-(instancetype) initWithName:(NSString *)name andIntervals:(NSArray *)intervals {
    self = [super init];
    if (self){
        self.workoutName = name;
        self.intervals = [[NSMutableArray alloc ] initWithArray: intervals];
    }
    return self;
}

- (void) addInterval:(Interval *)interval {
    [self.intervals addObject:interval];
}

@end
