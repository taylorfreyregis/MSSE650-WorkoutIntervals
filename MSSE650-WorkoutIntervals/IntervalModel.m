//
//  Interval.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "IntervalModel.h"

static NSString *const IDENTITY = @"identity";
static NSString *const NAME = @"name";
static NSString *const DURATION = @"duration";

@implementation IntervalModel

# pragma mark - Initialization

-(instancetype) initWithName:(NSString *)name andDuration:(int)seconds {
    self = [super init];
    if (self){
        self.name = name;
        self.duration = seconds;
    }
    return self;
}

-(instancetype) initWithId:(int)ident andName:(NSString *)name andDuration:(int)seconds {
    self = [super init];
    if (self){
        self.ident = ident;
        self.name = name;
        self.duration = seconds;
    }
    return self;
}

#pragma mark - NSCoding

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.ident = [aDecoder decodeIntForKey:IDENTITY];
        self.name = [aDecoder decodeObjectForKey:NAME];
        self.duration = [aDecoder decodeIntForKey:DURATION];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:self.ident forKey:IDENTITY];
    [aCoder encodeObject:self.name forKey:NAME];
    [aCoder encodeInt:self.duration forKey:DURATION];
}

# pragma mark - NSObject

- (NSString *) description {
    return [NSString stringWithFormat:@"Interval - Id: %d, Name: %@, Duration: %d", self.ident, self.name, self.duration];
}

@end
