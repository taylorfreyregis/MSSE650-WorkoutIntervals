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
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:INTERVAL inManagedObjectContext:[CoreDataManager manager].managedObjectContext];
    [managedObject setValue:interval.name forKey:NAME];
    [managedObject setValue:[NSNumber numberWithInt:interval.duration] forKey:DURATION];
    
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
    NSError *error;
    NSArray *fetchedObjects = [[CoreDataManager manager].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *managedObject in fetchedObjects) {
        Interval *interval = [[Interval alloc] initWithName:[managedObject valueForKey:NAME]  andDuration:[[managedObject valueForKey:DURATION] intValue]];
        NSLog(@"Interval retrieved: %@", interval.description);
        [intervals addObject:interval];
    }
    
    return intervals;
}

- (Interval *) updateInterval: (Interval *)interval {
    
    return interval;
}

- (Interval *) deleteInterval: (Interval *)interval {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:INTERVAL inManagedObjectContext:[CoreDataManager manager].managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@ AND duration = %d", interval.name, interval.duration];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [[CoreDataManager manager].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedObjects count] == 1) {
        NSManagedObject *managedObject = [fetchedObjects objectAtIndex:0];
        [[CoreDataManager manager].managedObjectContext deleteObject:managedObject];
    }
    
    return interval;
}

@end
