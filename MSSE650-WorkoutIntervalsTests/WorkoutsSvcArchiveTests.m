//
//  WorkoutsSvcArchiveTests.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "WorkoutModel.h"
#import "WorkoutSvcArchive.h"

@interface WorkoutsSvcArchiveTests : XCTestCase

@end

@implementation WorkoutsSvcArchiveTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIntervalSvcArchive {
    NSLog(@"Beginning WorkoutsSvcArchiveTests Test");
    
    int initialCount = (int)[[[WorkoutSvcArchive workoutSvcSingleton] retrieveAllWorkouts] count];
    
    IntervalModel *intervalOne = [[IntervalModel alloc] initWithName:@"Testing Interval 1" andDuration:180];
    IntervalModel *intervalTwo = [[IntervalModel alloc] initWithName:@"Testing Interval 2" andDuration:360];
    
    WorkoutModel *workoutOne = [[WorkoutModel alloc] initWithName:@"WorkoutOne" andIntervals:[NSArray arrayWithObjects:intervalOne, intervalTwo, intervalOne, nil]];
    WorkoutModel *workoutTwo = [[WorkoutModel alloc] initWithName:@"WorkoutTwo" andIntervals:[NSArray arrayWithObjects:intervalTwo, intervalOne, intervalTwo, nil]];
    
    [[WorkoutSvcArchive workoutSvcSingleton] createWorkout:workoutOne];
    [[WorkoutSvcArchive workoutSvcSingleton] createWorkout:workoutTwo];
    
    int finalCount = (int)[[[WorkoutSvcArchive workoutSvcSingleton] retrieveAllWorkouts] count];
    
    XCTAssertEqual(initialCount + 2, finalCount, @"Initial Count: %d Final Count: %d", initialCount, finalCount);
    
    NSLog(@"Count of workouts retrieved: %d", finalCount);
    
    NSLog(@"Ending WorkoutsSvcArchiveTests Test");
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
