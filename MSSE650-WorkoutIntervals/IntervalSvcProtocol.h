//
//  IntervalSvcProtocol.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/22/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interval.h"

@protocol IntervalSvcProtocol <NSObject>

+ (id) intervalSvcSingleton;

- (Interval *) createInterval: (Interval *)interval;
- (NSMutableArray *) retrieveAllIntervals;
- (Interval *) updateInterval: (Interval *)interval;
- (Interval *) deleteInterval: (Interval *)interval;

@end
