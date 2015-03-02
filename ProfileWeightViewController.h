//
//  ProfileWeightViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDatabaseSvc.h"

@interface ProfileWeightViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) ProfileModel *profile;

@property (weak, nonatomic) IBOutlet UINavigationItem *profileTitle;

@property (weak, nonatomic) IBOutlet UITableView *profileWeightTableView;

@property (weak, nonatomic) IBOutlet UITextField *profileWeightTextField;

- (IBAction)addWeightToProfile:(id)sender;

@end
