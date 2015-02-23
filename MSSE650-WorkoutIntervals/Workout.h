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
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSOrderedSet *intervals;
@end

@interface Workout (CoreDataGeneratedAccessors)

- (void)insertObject:(Interval *)value inIntervalsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromIntervalsAtIndex:(NSUInteger)idx;
- (void)insertIntervals:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeIntervalsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInIntervalsAtIndex:(NSUInteger)idx withObject:(Interval *)value;
- (void)replaceIntervalsAtIndexes:(NSIndexSet *)indexes withIntervals:(NSArray *)values;
- (void)addIntervalsObject:(Interval *)value;
- (void)removeIntervalsObject:(Interval *)value;
- (void)addIntervals:(NSOrderedSet *)values;
- (void)removeIntervals:(NSOrderedSet *)values;
@end
