//
//  IntervalSvcCoreData.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/21/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "IntervalSvcCoreData.h"
#import "Constants.h"
#import "CoreDataManager.h"

@implementation IntervalSvcCoreData

NSMutableArray *intervals;

# pragma mark Singleton Methods

+ (id) intervalSvcSingleton {
    static IntervalSvcCoreData *intervalSingleton = nil;
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
        intervals = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Interval Service Implementation

- (Interval *) createInterval: (Interval *)interval {
    
    NSError *error;
    if (![[CoreDataManager manager].managedObjectContext save:&error]) {
        NSLog(@"Error creating interval: %@", [error localizedDescription]);
    }
    
    return interval;
}

- (NSMutableArray *) retrieveAllIntervals {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:INTERVAL inManagedObjectContext:[CoreDataManager manager].managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:DURATION ascending:true];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    NSError *error;
    NSArray *fetchedObjects = [[CoreDataManager manager].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        NSLog(@"Error fetching all Intervals, %@", [error localizedDescription]);
    }
    
    NSMutableArray *mutableIntervals = [[NSMutableArray alloc] initWithArray:fetchedObjects];
    
    return mutableIntervals;
}

- (Interval *) updateInterval: (Interval *)interval {
    
    NSError *error;
    if (![[CoreDataManager manager].managedObjectContext save:&error]) {
        NSLog(@"Update Interval error: %@", [error localizedDescription]);
    }
    
    return interval;
}

- (Interval *) deleteInterval: (Interval *)interval {
    
    [[CoreDataManager manager].managedObjectContext deleteObject:interval];
    
    return interval;
}

+ (Interval *) createManagedInterval {
    
    Interval *interval = [NSEntityDescription insertNewObjectForEntityForName:INTERVAL inManagedObjectContext:[CoreDataManager manager].managedObjectContext];
    
    return interval;
}

@end
