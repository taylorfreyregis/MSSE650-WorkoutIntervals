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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Static models

// Since we don't have web services or anything stored yet, just create static resources for the workouts
- (NSArray *) createIntervals {
    Interval *intervalOne = [[Interval alloc] initWithName:@"60 Seconds" andDuration:60];
    Interval *intervalTwo = [[Interval alloc] initWithName:@"90 Seconds" andDuration:90];
    Interval *intervalThree = [[Interval alloc] initWithName:@"3 minutes" andDuration:180];
    Interval *intervalFour = [[Interval alloc] initWithName:@"5 minutes" andDuration:300];
    
    return [[NSArray alloc] initWithObjects:intervalOne, intervalTwo, intervalThree, intervalFour, nil];
}

- (NSArray *) createWorkouts {
    NSArray *intervals = [self createIntervals];
    NSArray *firstWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[0], intervals[1], nil];
    NSArray *secondWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[1], intervals[1], nil];
    NSArray *thirdWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[2], intervals[1], nil];
    NSArray *fourthWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[3], intervals[1], nil];
    NSArray *fifthWorkoutIntervals = [[NSArray alloc] initWithObjects:intervals[3], intervals[1], intervals[2], intervals[1], nil];
    
    Workout *first = [[Workout alloc]initWithName:@"60 On / 90 Off" andIntervals:firstWorkoutIntervals];
    Workout *second = [[Workout alloc]initWithName:@"90 On / 90 Off" andIntervals:secondWorkoutIntervals];
    Workout *third = [[Workout alloc]initWithName:@"3 On / 90 Off" andIntervals:thirdWorkoutIntervals];
    Workout *fourth = [[Workout alloc]initWithName:@"5 On / 90 Off" andIntervals:fourthWorkoutIntervals];
    Workout *fifth = [[Workout alloc]initWithName:@"5 On / 90 Off / 3 On / 90 Off" andIntervals:fifthWorkoutIntervals];
    
    return [[NSArray alloc]initWithObjects:first, second, third, fourth, fifth, nil];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Verify the segue via the identifier
    if ([[segue identifier] isEqualToString:@"initialWorkouts"]) {
        // Pass along the information necessary
        // However, the next ViewController is a Navigation Controller, not the Table View Controller we want.
        // So we'll have to get it.
        UINavigationController *navigationController = segue.destinationViewController;
        WorkoutsTableViewController *workoutsTableViewController = [[navigationController viewControllers] objectAtIndex:0];
        workoutsTableViewController.workouts = [[NSMutableArray alloc]initWithArray:[self createWorkouts]];
        
    }
    
}


@end
