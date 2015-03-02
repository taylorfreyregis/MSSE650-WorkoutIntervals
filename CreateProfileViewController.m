//
//  CreateProfileViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "CreateProfileViewController.h"
#import "ProfileDatabaseSvc.h"
#import "Constants.h"

@implementation CreateProfileViewController

// For source, see the CreateIntervalViewController
UIGestureRecognizer *tapper;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNumericTextFields];
    [self initTapper];
}

- (void) initNumericTextFields {
    
    // Set the delegate to be able to prevent/validate numeric only textfields
    [self.profileAgeTextField setDelegate:self];
    
    // Number keyboard
    [self.profileAgeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    // Initial Value
    self.profileAgeTextField.text = @"0";
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

// Forces numeric values
- (BOOL) textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange) range replacementString:(NSString *) string {
    
    if (textField == self.profileAgeTextField || textField == self.profileInitialWeight) {
        
        // Numeric hours ( < 24) only
        
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:NUMERIC_VALUES] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
        
    }
    
    // Default behavior
    return true;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    // Should we wish to enforce a range, here would it go
    
    // Dismiss keyboard
    [textField resignFirstResponder];
}

- (IBAction)saveProfileButton:(id)sender {
    // Save to IntervalService
    
    if ([self validate]) {
        
        // Create Profile
        ProfileModel *profile = [[ProfileModel alloc] init];
        profile.name = self.profileNameTextField.text;
        profile.age = [self.profileAgeTextField.text intValue];
        int weight = [self.profileInitialWeight.text intValue];
        
        // Save Profile
        [[ProfileDatabaseSvc profileSvcSingleton] createProfile:profile];
        
        [[ProfileDatabaseSvc profileSvcSingleton] addWeightMeasurement:weight ForProfile:profile];
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)cancelProfileButton:(id)sender {
    // Cancel. Just pop the navigation stack
    [self.navigationController popViewControllerAnimated:true];
}

/**
 *  Validates the inputs before saving. Must be a name and a time interval to be saved. No checks in place to verify if it currently exists in the collection.
 *
 *  @return true if the input values are valid, false otherwise
 */
- (bool) validate {
    
    NSString *name = [self.profileNameTextField text];
    
    if (name == nil || name.length == 0) {
        return false;
    }
    
    int age = [self.profileAgeTextField.text intValue];
    
    if (age <= 0) {
        return false;
    }
    
    int weight = [self.profileInitialWeight.text intValue];
    
    if (weight <= 0) {
        return false;
    }
    
    return true;
}

@end
