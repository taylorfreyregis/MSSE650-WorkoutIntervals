//
//  IntervalSvcArchive.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "IntervalSvcArchive.h"

@implementation IntervalSvcArchive

NSString *filePath;

NSMutableArray *intervals;

# pragma mark Singleton Methods

+ (id) intervalSvcSingleton {
    static IntervalSvcArchive *intervalSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intervalSingleton = [[self alloc] init];
    });
    return intervalSingleton;
}

# pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeFromArchive];
    }
    return self;
}

- (void) initializeFromArchive {
    [self getFilePath];
    [self readArchive];
}

- (void) getFilePath {
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
    filePath = [[NSString alloc] initWithString:[documentsDirectoryPath stringByAppendingPathComponent:@"Intervals.archive"]];
}

- (void) readArchive {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        intervals = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        intervals = [[NSMutableArray alloc] init];
    }
}

# pragma mark IntervalSvc Implementation

- (IntervalModel *) createInterval: (IntervalModel *)interval {
    
    [intervals addObject:interval];
    [self writeArchive];
    return interval;
}

- (NSMutableArray *) retrieveAllIntervals {
    
    return intervals;
}

- (IntervalModel *) updateInterval: (IntervalModel *)interval {
    
    int location = (int)[intervals indexOfObject:interval];
    
    [intervals replaceObjectAtIndex:location withObject:interval];
    [self writeArchive];
    return interval;
}

- (IntervalModel *) deleteInterval: (IntervalModel *)interval {
    
    [intervals removeObject:interval];
    [self writeArchive];
    return interval;
}

# pragma mark - Archiving

- (void) writeArchive {
    [NSKeyedArchiver archiveRootObject:intervals toFile:filePath];
}

@end
