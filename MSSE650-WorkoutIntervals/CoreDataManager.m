//
//  CoreDataManager.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/22/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

NSManagedObjectModel *managedObjectModel;
NSPersistentStoreCoordinator *persistentStoreCoordinator;

static CoreDataManager* manager;

//Create Singleton instance of the database.
+(CoreDataManager *)manager {
    if (manager == nil) {
        manager = [[CoreDataManager alloc] init];
    }
    return manager;
}

-(id) init {
    if (self = [super init]) {
        [self initCoreData];
    }
    return self;
}

- (void) initCoreData {
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *storeURL = [[self documentsDirectory] URLByAppendingPathComponent:@"WorkoutIntervalDatabase.sqlite"];
    NSError *error = nil;
    
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    if ([persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [self.managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    } else {
        NSLog(@"There was an error: %@", error);
    }
}

- (NSURL *)documentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
