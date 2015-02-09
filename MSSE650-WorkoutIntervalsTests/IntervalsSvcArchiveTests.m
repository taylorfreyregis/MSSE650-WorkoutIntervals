//
//  IntervalsSvcArchiveTests.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Interval.h"
#import "IntervalSvcArchive.h"

@interface IntervalsSvcArchiveTests : XCTestCase

@end

@implementation IntervalsSvcArchiveTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIntervalSvcArchive {
    NSLog(@"Beginning IntervalSvcArchive Test");
    
    int initialCount = (int)[[[IntervalSvcArchive intervalSvcSingleton] retrieveAllIntervals] count];
    
    Interval *intervalOne = [[Interval alloc] initWithName:@"Testing Interval 1" andDuration:180];
    Interval *intervalTwo = [[Interval alloc] initWithName:@"Testing Interval 2" andDuration:360];
    
    [[IntervalSvcArchive intervalSvcSingleton] createInterval:intervalOne];
    
    [[IntervalSvcArchive intervalSvcSingleton] createInterval:intervalTwo];
    
    int finalCount = (int)[[[IntervalSvcArchive intervalSvcSingleton] retrieveAllIntervals] count];
    
    XCTAssertEqual(initialCount + 2, finalCount, @"Initial Count: %d Final Count: %d", initialCount, finalCount);
    
    NSLog(@"Count of intervals retrieved: %d", finalCount);
    NSLog(@"Ending IntervalSvcArchive Test");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
