//
//  Interval.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "Interval.h"

@implementation Interval

-(instancetype) initWithName:(NSString *)name andDuration:(int)seconds {
    self = [super init];
    if (self){
        self.intervalName = name;
        self.duration = seconds;
    }
    return self;
}
@end
