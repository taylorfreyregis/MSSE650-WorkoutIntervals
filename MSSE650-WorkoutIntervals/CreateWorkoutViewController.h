//
//  CreateWorkoutViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntervalPickerViewController.h"
#import "WorkoutModel.h"

@protocol WorkoutCreatedDelegate <NSObject>

@required
- (void) workoutCreated:(WorkoutModel *) workout;

@end

@interface CreateWorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, IntervalSelectedDelegate>

@property (nonatomic) id<WorkoutCreatedDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UITextField *workoutNameTextField;

- (IBAction)cancelWorkoutButton:(id)sender;

- (IBAction)saveWorkoutButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *intervalTableView;

@end
