//
//  Workout.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalModel.h"

@interface WorkoutModel : NSObject <NSCoding>

@property (nonatomic) int ident;
@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray *intervals;
@property (nonatomic, readonly) int duration;

- (instancetype) initWithId:(int)ident andName:(NSString *)name andIntervals:(NSArray *)intervals;
- (instancetype) initWithId:(int)ident andName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name andIntervals:(NSArray *) intervals;

- (void) addInterval:(IntervalModel *) interval;

@end
