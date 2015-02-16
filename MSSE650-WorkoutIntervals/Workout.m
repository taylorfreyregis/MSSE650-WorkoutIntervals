//
//  Workout.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "Workout.h"

static NSString *const IDENTITY = @"identity";
static NSString *const NAME = @"name";
static NSString *const INTERVALS = @"intervals";

@implementation Workout

#pragma mark - Initialization

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

-(instancetype) initWithId:(int)ident andName:(NSString *)name andIntervals:(NSArray *)intervals {
    self = [super init];
    if (self){
        self.ident = ident;
        self.name = name;
        self.intervals = [[NSMutableArray alloc] init];
        if (intervals != nil && [intervals count] > 0) {
            [self.intervals addObjectsFromArray:intervals];
        }
        [self calculateDuration];
    }
    return self;
}

#pragma mark - NSCoding

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.ident = [aDecoder decodeIntForKey:IDENTITY];
        self.name = [aDecoder decodeObjectForKey:NAME];
        self.intervals = [aDecoder decodeObjectForKey:INTERVALS];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:self.ident forKey:IDENTITY];
    [aCoder encodeObject:self.name forKey:NAME];
    [aCoder encodeObject:self.intervals forKey:INTERVALS]; // will this work?
}

# pragma mark - NSObject

- (NSString *) description {
    return [NSString stringWithFormat:@"Interval - Id: %d, Name: %@, Duration: %d", self.ident, self.name, self.duration];
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
