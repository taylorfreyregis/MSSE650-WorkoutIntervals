//
//  ProfileDatabaseSvc.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileSvc.h"

@interface ProfileDatabaseSvc : NSObject <ProfileSvc>

- (ProfileModel *)retrieveProfileWithId:(int) ident;
- (bool) addWeightMeasurement:(int) weight ForProfile:(ProfileModel *) profile;
- (NSMutableDictionary *)retrieveAllWeightsForProfile:(ProfileModel *) profile;

@end
