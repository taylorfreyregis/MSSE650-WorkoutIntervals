//
//  MainViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/23/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "MainViewController.h"
#import "Interval.h"
#import "Workout.h"
#import "WorkoutsTableViewController.h"

@interface MainViewController ()

@property (nonatomic) NSMutableArray *intervals;
@property (nonatomic) NSMutableArray *workouts;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Verify the segue via the identifier
    if ([[segue identifier] isEqualToString:@"MainToWorkouts"]) {
        
        WorkoutsTableViewController *destination = segue.destinationViewController;
        
        WorkoutSvcCache *workoutSvc = [[WorkoutSvcCache alloc] init];
        
        destination.workouts = [[NSMutableArray alloc] initWithArray:[workoutSvc retrieveAllWorkouts]];
        
    }
    
}
*/

@end
