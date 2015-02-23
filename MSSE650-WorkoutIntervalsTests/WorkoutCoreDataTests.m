//
//  WorkoutCoreDataTests.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/22/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Workout.h"
#import "WorkoutSvcCoreData.h"
#import "IntervalSvcCoreData.h"
#import "Utilities.h"

@interface WorkoutCoreDataTests : XCTestCase

@end

@implementation WorkoutCoreDataTests

NSArray *testIntervals;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [self clearAllIntervals];
    [self clearAllWorkouts];
    
    for (int i, x = 0; i < 10; i++, x += 30) {
        Interval *interval = [IntervalSvcCoreData createManagedInterval];
        interval.name = [NSString stringWithFormat:@"%d seconds", x];
        interval.duration = [NSNumber numberWithInt:x];
        [[IntervalSvcCoreData intervalSvcSingleton] createInterval:interval];
    }
    
    testIntervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    // Clear all the intervals created in the setUp
    [self clearAllIntervals];
    
    // Clear all the workouts created throughout the process (Hopefully delete works...)
    [self clearAllWorkouts];
}

- (void) clearAllIntervals {
    for (Interval *interval in [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals]) {
        [[IntervalSvcCoreData intervalSvcSingleton] deleteInterval:interval];
    }
}

- (void) clearAllWorkouts {
    for (Workout *workout in [[WorkoutSvcCoreData workoutSvcSingleton] retrieveAllWorkouts]) {
        [[WorkoutSvcCoreData workoutSvcSingleton] deleteWorkout:workout];
    }
}

- (void) testCreateWorkout {
    Workout *start = [WorkoutSvcCoreData createManagedWorkout];
    start.name = @"CreateWorkout";
    NSMutableArray *intervalsToAdd = [[NSMutableArray alloc] init];
    for (int i = 0; i < testIntervals.count; i++) {
        if (i % 3 == 0) {
            [intervalsToAdd addObject:[testIntervals objectAtIndex:i]];
        }
    }
    start.intervals = [[NSOrderedSet alloc] initWithArray:intervalsToAdd];
    
    [[WorkoutSvcCoreData workoutSvcSingleton] createWorkout:start];
    
    NSArray *results = [[WorkoutSvcCoreData workoutSvcSingleton] retrieveAllWorkouts];
    
    XCTAssert(results.count >= 1 && [Utilities getDurationForWorkout:((Workout *)[results objectAtIndex:0])] > 0);
}

- (void) testRetrieveAllWorkouts {
    Workout *start = [WorkoutSvcCoreData createManagedWorkout];
    start.name = @"CreateWorkout";
    NSMutableArray *intervalsToAdd = [[NSMutableArray alloc] init];
    for (int i = 0; i < testIntervals.count; i++) {
        if (i % 2 == 0) {
            [intervalsToAdd addObject:[testIntervals objectAtIndex:i]];
        }
    }
    start.intervals = [[NSOrderedSet alloc] initWithArray:intervalsToAdd];
    [[WorkoutSvcCoreData workoutSvcSingleton] createWorkout:start];
    
    NSArray *results = [[WorkoutSvcCoreData workoutSvcSingleton] retrieveAllWorkouts];
    
    XCTAssert(results.count >= 1);
}

- (void) testDeleteWorkout {
    Workout *start = [WorkoutSvcCoreData createManagedWorkout];
    start.name = @"DeleteWorkout";
    NSMutableArray *intervalsToAdd = [[NSMutableArray alloc] init];
    for (int i = 0; i < testIntervals.count; i++) {
        if (i % 5 == 0) {
            [intervalsToAdd addObject:[testIntervals objectAtIndex:i]];
        }
    }
    start.intervals = [[NSOrderedSet alloc] initWithArray:intervalsToAdd];
    [[WorkoutSvcCoreData workoutSvcSingleton] createWorkout:start];
    
    NSArray *results = [[WorkoutSvcCoreData workoutSvcSingleton] retrieveAllWorkouts];
    Workout *found;
    for (Workout *workout in results) {
        if ([workout.name isEqualToString:@"DeleteWorkout"]) {
            found = workout;
        }
    }
    
    if (found != nil) {
        [[WorkoutSvcCoreData workoutSvcSingleton] deleteWorkout:found];
    }
    
    NSArray *lastCheck = [[WorkoutSvcCoreData workoutSvcSingleton] retrieveAllWorkouts];
    Workout *searched = nil;
    for (Workout *workout in lastCheck) {
        if ([workout.name isEqualToString:@"DeleteWorkout"]) {
            searched = workout;
        }
    }
    
    XCTAssert(searched == nil);
}

- (void) testUpdateWorkout {
    Workout *start = [WorkoutSvcCoreData createManagedWorkout];
    start.name = @"UpdateWorkout";
    NSMutableArray *intervalsToAdd = [[NSMutableArray alloc] init];
    for (int i = 0; i < testIntervals.count; i++) {
        if (i % 4 == 0) {
            [intervalsToAdd addObject:[testIntervals objectAtIndex:i]];
        }
    }
    start.intervals = [[NSOrderedSet alloc] initWithArray:intervalsToAdd];
    [[WorkoutSvcCoreData workoutSvcSingleton] createWorkout:start];
    
    NSArray *results = [[WorkoutSvcCoreData workoutSvcSingleton] retrieveAllWorkouts];
    Workout *found;
    for (Workout *workout in results) {
        if ([workout.name isEqualToString:@"UpdateWorkout"]) {
            found = workout;
        }
    }
    
    XCTAssert([Utilities getDurationForWorkout:found] > 0);
    
    found.intervals = [[NSOrderedSet alloc] init];
    
    [[WorkoutSvcCoreData workoutSvcSingleton] updateWorkout:found];
    
    NSArray *again = [[WorkoutSvcCoreData workoutSvcSingleton] retrieveAllWorkouts];
    Workout *foundagain;
    for (Workout *workout in again) {
        if ([workout.name isEqualToString:@"UpdateWorkout"]) {
            foundagain = workout;
        }
    }
    
    XCTAssert([Utilities getDurationForWorkout:found] <= 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
