//
//  ProfileModel.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileModel : NSObject <NSCoding>

@property (nonatomic) int ident;
@property (nonatomic) NSString *name;
@property (nonatomic) int age;

-(instancetype) initWithId:(int)ident andName:(NSString *)name andAge:(int)years;
-(instancetype) initWithName:(NSString *)name andAge:(int)years;

@end
