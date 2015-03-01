//
//  PerformWorkoutViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutModel.h"

@interface PerformWorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UINavigationItem *workoutTitle;

@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;

- (IBAction)startButtonAction:(id)sender;
- (IBAction)pauseContinueButtonAction:(id)sender;
- (IBAction)finishButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *startButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *pauseContinueButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *finishButtonOutlet;

@property (nonatomic) WorkoutModel *workout;

@property (weak, nonatomic) IBOutlet UITableView *intervalsTableView;


@end
