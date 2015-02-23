//
//  WorkoutSvcCoreData.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/22/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WorkoutSvcCoreData.h"
#import "Constants.h"
#import "CoreDataManager.h"

@implementation WorkoutSvcCoreData

NSMutableArray *workouts;

#pragma mark - Initialization

+ (id) workoutSvcSingleton {
    static WorkoutSvcCoreData *workoutSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        workoutSingleton = [[self alloc] init];
    });
    return workoutSingleton;
}

- (id) init {
    if (self = [super init]) {
        workouts = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}


#pragma mark - Interval Service Implementation

- (Workout *) createWorkout:(Workout *)workout {
    
    NSError *error;
    if (![[CoreDataManager manager].managedObjectContext save:&error]) {
        NSLog(@"Error creating workout: %@", [error localizedDescription]);
    }
    
    return workout;
}

- (NSMutableArray *) retrieveAllWorkouts {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:WORKOUT inManagedObjectContext:[CoreDataManager manager].managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:NAME ascending:true];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    NSError *error;
    NSArray *fetchedObjects = [[CoreDataManager manager].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        NSLog(@"Error fetching all workouts, %@", [error localizedDescription]);
    }
    
    NSMutableArray *mutableIntervals = [[NSMutableArray alloc] initWithArray:fetchedObjects];
    
    return mutableIntervals;
}

- (Workout *) updateWorkout: (Workout *)workout {
    
    NSError *error;
    if (![[CoreDataManager manager].managedObjectContext save:&error]) {
        NSLog(@"Update workout error: %@", [error localizedDescription]);
    }
    
    return workout;
}

- (Workout *) deleteWorkout: (Workout *)workout {
    
    [[CoreDataManager manager].managedObjectContext deleteObject:workout];
    
    return workout;
}

+ (Workout *) createManagedWorkout {
    
    Workout *workout = [NSEntityDescription insertNewObjectForEntityForName:WORKOUT inManagedObjectContext:[CoreDataManager manager].managedObjectContext];
    workout.name = @"";
    workout.duration = 0;
    
    return workout;
}


@end
