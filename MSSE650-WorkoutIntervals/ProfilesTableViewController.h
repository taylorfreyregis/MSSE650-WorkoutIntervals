//
//  ProfilesTableViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilesTableViewController : UITableViewController

@property (nonatomic) NSMutableArray *profiles;

@property (strong, nonatomic) IBOutlet UITableView *profileTableView;

- (IBAction)doneButton:(id)sender;


@end
