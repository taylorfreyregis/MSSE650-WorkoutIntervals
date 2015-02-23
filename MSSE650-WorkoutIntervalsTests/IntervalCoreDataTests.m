//
//  IntervalCoreDataTests.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/22/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IntervalSvcCoreData.h"
#import "Constants.h"

@interface IntervalCoreDataTests : XCTestCase

@end

@implementation IntervalCoreDataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateInterval {
    Interval *interval = [IntervalSvcCoreData createManagedInterval];
    interval.name = @"30 second test";
    interval.duration = [NSNumber numberWithInt:30];
    
    [[IntervalSvcCoreData intervalSvcSingleton] createInterval:interval];
    
    NSArray *allIntervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
    
    XCTAssert(allIntervals.count >= 1);
}

- (void)testRetrieveAllIntervals {
    NSString *intervalName = @"60 second test";
    Interval *interval = [IntervalSvcCoreData createManagedInterval];
    interval.name = intervalName;
    interval.duration = [NSNumber numberWithInt:60];
    [[IntervalSvcCoreData intervalSvcSingleton] createInterval:interval];
    
    NSArray *allIntervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
    
    XCTAssert(allIntervals.count >= 1);
}

- (void)testUpdateInterval {
    
    // Test was persisting various objects...
    NSArray *deleteIntervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
    for (int i = 0; i < deleteIntervals.count; i++) {
        [[IntervalSvcCoreData intervalSvcSingleton] deleteInterval:[deleteIntervals objectAtIndex:i]];
    }
    
    NSString *intervalName = @"90 second test";
    Interval *interval = [IntervalSvcCoreData createManagedInterval];
    interval.name = intervalName;
    interval.duration = [NSNumber numberWithInt:60];
    [[IntervalSvcCoreData intervalSvcSingleton] createInterval:interval];
    
    NSArray *allIntervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
    for (int i = 0; i < allIntervals.count; i++) {
        Interval *toUpdate = ((Interval *)[allIntervals objectAtIndex:i]);
        if (toUpdate != nil && [toUpdate.name isEqualToString:intervalName] && [toUpdate.duration intValue] == 60) {
            [toUpdate setValue:[NSNumber numberWithInt:90] forKey:DURATION];
//            toUpdate.duration = [NSNumber numberWithInt:90];
            NSLog(@"Updating interval");
            [[IntervalSvcCoreData intervalSvcSingleton] updateInterval:toUpdate];
            break;
        }
        NSLog(@"No matching interval found");
    }
    
    Interval *updateTest;
    NSArray *againIntervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
    for (int i = 0; i < againIntervals.count; i++) {
        Interval *updated = ((Interval *)[againIntervals objectAtIndex:i]);
        if (updated != nil && [updated.name isEqualToString:intervalName]) {
            updateTest = updated;
            break;
        }
    }
    
    XCTAssert([updateTest.duration intValue] == 90);
}

- (void) testDeleteInterval {
    NSString *intervalName = @"DeleteMe test";
    Interval *interval = [IntervalSvcCoreData createManagedInterval];
    interval.name = intervalName;
    interval.duration = [NSNumber numberWithInt:60];
    [[IntervalSvcCoreData intervalSvcSingleton] createInterval:interval];
    
    Interval *deleteMe;
    NSArray *allIntervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
    for (int i = 0; i < allIntervals.count; i++) {
        Interval *interval = ((Interval *)[allIntervals objectAtIndex:i]);
        if (interval != nil && [interval.name isEqualToString:intervalName]) {
            deleteMe = interval;
        }
    }
    
    [[IntervalSvcCoreData intervalSvcSingleton] deleteInterval:deleteMe];
    
    //Looping assertion?
    NSArray *againIntervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
    for (int i = 0; i < againIntervals.count; i++) {
        Interval *deleteCheck = ((Interval *)[againIntervals objectAtIndex:i]);
        XCTAssert(![deleteCheck.name isEqualToString:intervalName]);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
