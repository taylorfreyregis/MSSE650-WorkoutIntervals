//
//  ProfileSvc.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileModel.h"

@protocol ProfileSvc <NSObject>

+ (id) profileSvcSingleton;

- (ProfileModel *) createProfile: (ProfileModel *)profile;
- (NSMutableArray *) retrieveAllProfiles;
- (ProfileModel *) updateProfile: (ProfileModel *)profile;
- (ProfileModel *) deleteProfile: (ProfileModel *)profile;

@end
