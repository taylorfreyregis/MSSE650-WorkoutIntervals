//
//  CreateWorkoutViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateWorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UITextField *workoutNameTextView;
- (IBAction)setDurationButton:(id)sender;
- (IBAction)cancelWorkoutButton:(id)sender;

- (IBAction)addIntervalButton:(id)sender;
- (IBAction)saveWorkoutButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *intervalTableView;

@end
