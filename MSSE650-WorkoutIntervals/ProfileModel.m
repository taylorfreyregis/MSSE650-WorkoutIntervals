//
//  ProfileModel.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "ProfileModel.h"

@implementation ProfileModel

static NSString *const IDENTITY = @"identity";
static NSString *const NAME = @"name";
static NSString *const AGE = @"age";

# pragma mark - Initialization

-(instancetype) initWithName:(NSString *)name andAge:(int)years {
    self = [super init];
    if (self){
        self.name = name;
        self.age = years;
    }
    return self;
}

-(instancetype) initWithId:(int)ident andName:(NSString *)name andAge:(int)years {
    self = [super init];
    if (self){
        self.ident = ident;
        self.name = name;
        self.age = years;
    }
    return self;
}
#pragma mark - NSCoding

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.ident = [aDecoder decodeIntForKey:IDENTITY];
        self.name = [aDecoder decodeObjectForKey:NAME];
        self.age = [aDecoder decodeIntForKey:AGE];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:self.ident forKey:IDENTITY];
    [aCoder encodeObject:self.name forKey:NAME];
    [aCoder encodeInt:self.age forKey:AGE];
}

# pragma mark - NSObject

- (NSString *) description {
    return [NSString stringWithFormat:@"Interval - Id: %d, Name: %@, Age: %d", self.ident, self.name, self.age];
}

@end
