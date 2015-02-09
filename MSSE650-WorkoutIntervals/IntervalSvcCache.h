//
//  IntervalSvcCache.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalSvc.h"

@interface IntervalSvcCache : NSObject <IntervalSvc>

+ (id) intervalSvcCacheSingleton;

- (Interval *) createInterval: (Interval *)interval;
- (NSMutableArray *) retrieveAllIntervals;
- (Interval *) updateInterval: (Interval *)interval;
- (Interval *) deleteInterval: (Interval *)interval;

@end
