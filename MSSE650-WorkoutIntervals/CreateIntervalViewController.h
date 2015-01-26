//
//  CreateIntervalViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateIntervalViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *intervalNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *intervalNameTextField;
- (IBAction)intervalSetDuration:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *intervalDurationLabel;
- (IBAction)saveIntervalButton:(id)sender;

@end
