//
//  CreateIntervalViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "CreateIntervalViewController.h"
#import "IntervalSvcCache.h"
#import "Constants.h"

@interface CreateIntervalViewController ()

@end

@implementation CreateIntervalViewController

// Used to remove focus from the textfields http://stackoverflow.com/questions/5306240/iphone-dismiss-keyboard-when-touching-outside-of-textfield
UIGestureRecognizer *tapper;

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initSteppers];
    [self initTextFields];
    [self initTapper];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Initialization

- (void) initSteppers {
    self.hoursStepper.minimumValue = 0;
    self.hoursStepper.maximumValue = 24;
    self.hoursStepper.value = 0;
    self.hoursStepper.stepValue = 1;
    
    // Continuous vs autorepeat?
    self.hoursStepper.continuous = true;
    
    self.minutesStepper.minimumValue = 0;
    self.minutesStepper.maximumValue = 60;
    self.minutesStepper.value = 0;
    self.minutesStepper.stepValue = 5;
    
    // Continuous vs autorepeat?
    self.minutesStepper.autorepeat = true;
    
    self.secondsStepper.minimumValue = 0;
    self.secondsStepper.maximumValue = 60;
    self.secondsStepper.value = 0;
    self.secondsStepper.stepValue = 5;
    
    // Continuous vs autorepeat?
    self.secondsStepper.autorepeat = true;
}

- (void) initTextFields {
    
    // Set the delegate to be able to prevent/validate numeric only textfields
    [self.hoursTextField setDelegate:self];
    [self.minutesTextField setDelegate:self];
    [self.secondsTextField setDelegate:self];
    
    // Number keyboard
    [self.hoursTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.minutesTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.secondsTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    // Initial Value
    self.hoursTextField.text = [NSString stringWithFormat:@"%d", (int)self.hoursStepper.value];
    self.minutesTextField.text = [NSString stringWithFormat:@"%d", (int)self.minutesStepper.value];
    self.secondsTextField.text = [NSString stringWithFormat:@"%d", (int)self.secondsStepper.value];
}

- (void) initTapper {
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(viewEndEditing:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
}

- (void) viewEndEditing:(UITapGestureRecognizer *) sender {
    [self.view endEditing:true];
}

# pragma mark - UITextFieldDelegate

- (BOOL) textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange) range replacementString:(NSString *) string {
    
    if (textField == self.hoursTextField) {
        
        // Numeric hours ( < 24) only
        
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:NUMERIC_VALUES] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
        
    } else if (textField == self.minutesTextField || textField == self.secondsTextField) {
        
        // Numeric minutes/seconds ( < 60) only
        
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:NUMERIC_VALUES] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    
    // Default behavior
    return true;
}

// Use the steppers for the value holding.
- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    // Safe to assume the text is int because of the restrictions placed above in 'shouldChangeCharactersInRange'
    NSInteger intValue = [textField.text intValue];
    
    if (textField == self.hoursTextField) {
        
        if (intValue >= 0 && intValue <= 24) {
            
            self.hoursStepper.value = intValue;
        } else if (intValue < 0) {
            
            self.hoursStepper.value = 0;
            self.hoursTextField.text = [NSString stringWithFormat:@"%d", (int)self.hoursStepper.value];
        } else if (intValue > 24) {
            
            self.hoursStepper.value = 24;
            self.hoursTextField.text = [NSString stringWithFormat:@"%d", (int)self.hoursStepper.value];
        }
            
    } else if (textField == self.minutesTextField) {
        
        if (intValue >= 0 && intValue <= 60) {
            
            self.minutesStepper.value = intValue;
        } else if (intValue < 0) {
            
            self.minutesStepper.value = 0;
            self.minutesTextField.text = [NSString stringWithFormat:@"%d", (int)self.minutesStepper.value];
        } else if (intValue > 60) {
            
            self.minutesStepper.value = 60;
            self.minutesTextField.text = [NSString stringWithFormat:@"%d", (int)self.minutesStepper.value];
        }
        
    } else if (textField == self.secondsTextField) {
        
        if (intValue >= 0 && intValue <= 60) {
            
            self.secondsStepper.value = intValue;
        } else if (intValue < 0) {
            
            self.secondsStepper.value = 0;
            self.secondsTextField.text = [NSString stringWithFormat:@"%d", (int)self.secondsStepper.value];
        } else if (intValue > 60) {
            
            self.secondsStepper.value = 60;
            self.secondsTextField.text = [NSString stringWithFormat:@"%d", (int)self.secondsStepper.value];
        }
        
    }
    
    // Ignore any other textfields
    
    // Dismiss keyboard
    [textField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

# pragma mark - IBActions

- (IBAction)hoursStepperAction:(id)sender {
    
    self.hoursTextField.text = [NSString stringWithFormat:@"%d", (int)self.hoursStepper.value];
}

- (IBAction)minutesStepperAction:(id)sender {
    
    self.minutesTextField.text = [NSString stringWithFormat:@"%d", (int)self.minutesStepper.value];
}

- (IBAction)secondsStepperAction:(id)sender {
    
    self.secondsTextField.text = [NSString stringWithFormat:@"%d", (int)self.secondsStepper.value];
}

- (IBAction)saveIntervalButton:(id)sender {
    // Save to IntervalService
    
    if ([self validate]) {
        
        // Convert duration values
        int duration = (self.hoursStepper.value * 60 * 60)
        + (self.minutesStepper.value * 60)
        + (self.secondsStepper.value);
        
        // Create Interval
        Interval *interval = [[Interval alloc] initWithName:self.intervalNameTextField.text andDuration:duration];
        
        // Save Interval
        [[IntervalSvcCache intervalSvcCacheSingleton] createInterval:interval];
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)cancelIntervalButton:(id)sender {
    // Cancel. Just pop the navigation stack
    [self.navigationController popViewControllerAnimated:true];
}

/**
 *  Validates the inputs before saving. Must be a name and a time interval to be saved. No checks in place to verify if it currently exists in the collection.
 *
 *  @return true if the input values are valid, false otherwise
 */
- (bool) validate {
    
    NSString *name = [self.intervalNameTextField text];
    
    if (name == nil || name.length == 0) {
        return false;
    }
    
    int hours = (int)self.hoursStepper.value;
    int minutes = (int)self.minutesStepper.value;
    int seconds = (int)self.secondsStepper.value;
    
    if (hours == 0 && minutes == 0 && seconds == 0) {
        return false;
    }
    
    return true;
}

@end
