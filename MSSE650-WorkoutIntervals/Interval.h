//
//  Interval.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interval : NSObject

@property (nonatomic) int ident;
@property (nonatomic) NSString *intervalName;
@property (nonatomic) int duration;

-(instancetype) initWithName:(NSString *)name andDuration:(int)seconds;
    
@end
