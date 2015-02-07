//
//  CreateIntervalViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateIntervalViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *intervalNameTextField;

@property (weak, nonatomic) IBOutlet UILabel *intervalDurationLabel;

- (IBAction)intervalSetDuration:(id)sender;

- (IBAction)cancelIntervalButton:(id)sender;

- (IBAction)saveIntervalButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *intervalPicker;

@end
