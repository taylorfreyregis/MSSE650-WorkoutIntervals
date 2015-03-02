//
//  ProfileDatabaseSvcTests.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ProfileDatabaseSvc.h"

@interface ProfileDatabaseSvcTests : XCTestCase

@end

@implementation ProfileDatabaseSvcTests

ProfileModel *standardProfile;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    standardProfile = [[ProfileModel alloc] initWithName:@"Standard" andAge:45];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateProfile {
    ProfileModel *profile = [[ProfileModel alloc] initWithName:@"ExampleCreate" andAge:32];
    
    ProfileModel *result = [[ProfileDatabaseSvc profileSvcSingleton] createProfile:profile];
    
    XCTAssert(result.ident >= 0 && [result.name isEqualToString:@"ExampleCreate"] && result.age == 32);
}

- (void) testRetrieveAllProfiles {
    [self testCreateProfile];
    
    [[ProfileDatabaseSvc profileSvcSingleton] createProfile:standardProfile];
    
    NSArray *results = [[ProfileDatabaseSvc profileSvcSingleton] retrieveAllProfiles];
    
    XCTAssert(results.count >= 1);
    
}

- (void) testDeleteProfile {
    
    ProfileModel *start = [[ProfileModel alloc] initWithName:@"Delete Profile" andAge:75];
    
    ProfileModel *result = [[ProfileDatabaseSvc profileSvcSingleton] deleteProfile:start];
    
    XCTAssert(result.ident == start.ident);
    
}

- (void) testUpdateInterval {
    
    ProfileModel *updateMe = [[ProfileModel alloc] initWithName:@"Update Profile" andAge:30];
    
    ProfileModel *result = [[ProfileDatabaseSvc profileSvcSingleton] createProfile:updateMe];
    
    XCTAssert(result.age == 30);
    
    updateMe.age = 45;
    
    result = [[ProfileDatabaseSvc profileSvcSingleton] updateProfile:updateMe];
    
    XCTAssert(result.age == 45);
}

- (void) testAddWeightToProfile {
    [[ProfileDatabaseSvc profileSvcSingleton] addWeightMeasurement:200 ForProfile:standardProfile];
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    XCTAssert([results count] == 0);
    
    results = [[ProfileDatabaseSvc profileSvcSingleton] retrieveAllWeightsForProfile: standardProfile];
    
    XCTAssert([results count] >= 1);
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
