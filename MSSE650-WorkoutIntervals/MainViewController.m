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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

@end
