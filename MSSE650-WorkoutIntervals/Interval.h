//
//  Interval.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/22/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Interval : NSManagedObject

@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * ident;
@property (nonatomic, retain) NSString * name;

@end
