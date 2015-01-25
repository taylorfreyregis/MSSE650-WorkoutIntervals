//
//  Workout.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Workout : NSObject

@property (nonatomic) int ident;
@property (nonatomic) NSString *workoutName;
@property (nonatomic) NSArray *intervals;

@end
