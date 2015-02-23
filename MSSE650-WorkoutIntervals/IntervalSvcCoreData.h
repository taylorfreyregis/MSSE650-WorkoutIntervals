//
//  IntervalSvcCoreData.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/21/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "IntervalSvcProtocol.h"

@interface IntervalSvcCoreData : NSObject <IntervalSvcProtocol>

+ (Interval *) createManagedInterval;

@end
