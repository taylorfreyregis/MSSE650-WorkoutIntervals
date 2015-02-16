//
//  WorkoutsTableViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateWorkoutViewController.h"

@interface WorkoutsTableViewController : UITableViewController <WorkoutCreatedDelegate>

@property (nonatomic) NSMutableArray *workouts;

@property (strong, nonatomic) IBOutlet UITableView *workoutTableView;

- (IBAction)doneButton:(id)sender;

@end
