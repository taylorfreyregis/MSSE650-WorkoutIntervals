//
//  CreateIntervalViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateIntervalViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *intervalNameTextField;

- (IBAction)cancelIntervalButton:(id)sender;

- (IBAction)saveIntervalButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *hoursTextField;
@property (weak, nonatomic) IBOutlet UIStepper *hoursStepper;
- (IBAction)hoursStepperAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *minutesTextField;
@property (weak, nonatomic) IBOutlet UIStepper *minutesStepper;
- (IBAction)minutesStepperAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *secondsTextField;
@property (weak, nonatomic) IBOutlet UIStepper *secondsStepper;
- (IBAction)secondsStepperAction:(id)sender;

//@property (weak, nonatomic) IBOutlet UIPickerView *intervalPicker;

@end
