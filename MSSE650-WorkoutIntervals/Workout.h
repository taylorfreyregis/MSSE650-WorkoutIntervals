//
//  Workout.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/22/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Interval;

@interface Workout : NSManagedObject

@property (nonatomic, retain) NSNumber * ident;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *intervals;
@end

@interface Workout (CoreDataGeneratedAccessors)

- (void)addIntervalsObject:(Interval *)value;
- (void)removeIntervalsObject:(Interval *)value;
- (void)addIntervals:(NSSet *)values;
- (void)removeIntervals:(NSSet *)values;

@end
