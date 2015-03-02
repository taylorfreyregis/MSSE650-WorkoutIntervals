//
//  CreateProfileViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateProfileViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *profileNameTextField;

- (IBAction)cancelProfileButton:(id)sender;

- (IBAction)saveProfileButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *profileAgeTextField;

@property (weak, nonatomic) IBOutlet UITextField *profileInitialWeight;

@end
