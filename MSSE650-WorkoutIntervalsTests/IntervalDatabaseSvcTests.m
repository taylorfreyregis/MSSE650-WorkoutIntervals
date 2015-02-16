//
//  IntervalDatabaseSvcTests.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Interval.h"
#import "IntervalDatabaseSvc.h"

@interface IntervalDatabaseSvcTests : XCTestCase

@end

@implementation IntervalDatabaseSvcTests

Interval *result;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testCreateInterval {
    Interval *start = [[Interval alloc] initWithId:-99 andName:@"TestInterval" andDuration:60];
    
    result = [[IntervalDatabaseSvc intervalSvcSingleton] createInterval:start];
    
    XCTAssert(result.ident >= 0 && [result.name isEqualToString:@"TestInterval"] && result.duration == 60);
}

- (void) testRetrieveAllIntervals {
    [self testCreateInterval];
    
    NSArray *results = [[IntervalDatabaseSvc intervalSvcSingleton] retrieveAllIntervals];
    
    XCTAssert(results.count >= 1);
    
}

- (void) testDeleteInterval {
    
    Interval *start = [[Interval alloc] initWithId:result.ident andName:@"DoesntMatter" andDuration:90];
    
    result = [[IntervalDatabaseSvc intervalSvcSingleton] deleteInterval:start];
    
    XCTAssert(result.ident == start.ident);
    
}

- (void) testUpdateInterval {
    
    Interval *updateMe = [[Interval alloc] initWithName:@"UpdateMe" andDuration:900];
    
    result = [[IntervalDatabaseSvc intervalSvcSingleton] createInterval:updateMe];
    
    XCTAssert(result.duration == 900);
    
    updateMe.duration = 1800;
    
    result = [[IntervalDatabaseSvc intervalSvcSingleton] updateInterval:updateMe];
    
    XCTAssert(result.duration == 1800);
}


@end
