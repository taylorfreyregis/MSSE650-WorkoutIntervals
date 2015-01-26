//
//  CreateWorkoutViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntervalSvcCache.h"

@interface CreateWorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IntervalSvcCache *intervalSvcCache;
@property (weak, nonatomic) IBOutlet UILabel *workoutDurationLabel;
@property (weak, nonatomic) IBOutlet UITextField *workoutNameTextView;
@property (weak, nonatomic) IBOutlet UILabel *workoutNameLabel;
- (IBAction)setDurationButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *intervalTableView;

@end
