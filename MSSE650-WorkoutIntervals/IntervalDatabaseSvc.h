//
//  IntervalDatabaseSvc.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntervalSvc.h"

@interface IntervalDatabaseSvc : NSObject <IntervalSvc>

- (Interval *)retrieveIntervalWithId:(int) ident;

@end
