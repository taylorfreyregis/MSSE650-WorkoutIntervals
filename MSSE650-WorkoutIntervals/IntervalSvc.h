//
//  IntervalSvc.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalModel.h"

@protocol IntervalSvc <NSObject>

+ (id) intervalSvcSingleton;

- (IntervalModel *) createInterval: (IntervalModel *)interval;
- (NSMutableArray *) retrieveAllIntervals;
- (IntervalModel *) updateInterval: (IntervalModel *)interval;
- (IntervalModel *) deleteInterval: (IntervalModel *)interval;

@end
