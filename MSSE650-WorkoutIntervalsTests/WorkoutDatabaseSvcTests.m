//
//  WorkoutDatabaseSvcTests.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Workout.h"
#import "WorkoutDatabaseSvc.h"

@interface WorkoutDatabaseSvcTests : XCTestCase

@end

@implementation WorkoutDatabaseSvcTests

NSMutableArray *intervals;
Workout *result;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    intervals = [[NSMutableArray alloc] initWithObjects:
                 [[Interval alloc] initWithName:@"First" andDuration:60],
                 [[Interval alloc] initWithName:@"SECOND" andDuration:60],
                 [[Interval alloc] initWithName:@"Third" andDuration:60],
                 [[Interval alloc] initWithName:@"Fourth" andDuration:60],
                 [[Interval alloc] initWithName:@"Fifth" andDuration:60],
                 [[Interval alloc] initWithName:@"6th" andDuration:60],
                 [[Interval alloc] initWithName:@"Seventh" andDuration:60],
                 [[Interval alloc] initWithName:@"EIGTH" andDuration:60],
                 nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void) testCreateInterval {
    Workout *start = [[Workout alloc] initWithName:@"TestWorkout" andIntervals:intervals];
    
    result = [[WorkoutDatabaseSvc workoutSvcSingleton] createWorkout:start];
    
    XCTAssert(result.ident >= 0 && [result.name isEqualToString:@"TestWorkout"] && result.intervals.count == 8);
}

- (void) testRetrieveAllIntervals {
    [self testCreateInterval];
    
    NSArray *results = [[WorkoutDatabaseSvc workoutSvcSingleton] retrieveAllWorkouts];
    
    XCTAssert(results.count >= 1);
    
}

- (void) testDeleteInterval {
    
    Workout *start = [[Workout alloc] initWithName:@"TestDelete" andIntervals:intervals];
    result = [[WorkoutDatabaseSvc workoutSvcSingleton] deleteWorkout:start];
    
    XCTAssert(result.ident == start.ident);
    
}

- (void) testUpdateInterval {
    
    Workout *updateMe = [[Workout alloc] initWithName:@"UpdateWorkout" andIntervals:intervals];
    
    
    result = [[WorkoutDatabaseSvc workoutSvcSingleton] createWorkout:updateMe];
    
    XCTAssert([result.name isEqualToString:@"UpdateWorkout"]);
    
    updateMe.name = @"Updated";
    
    result = [[WorkoutDatabaseSvc workoutSvcSingleton] updateWorkout:updateMe];
    
    XCTAssert([result.name isEqualToString:@"Updated"]);
}



@end
