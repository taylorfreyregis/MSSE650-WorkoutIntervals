//
//  CreateWorkoutViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "CreateWorkoutViewController.h"
#import "Workout.h"
#import "Interval.h"
#import "IntervalSvcCache.h"
#import "WorkoutSvcCache.h"
#import "Utilities.h"

#import "IntervalPickerViewController.h"

@interface CreateWorkoutViewController ()

@end

@implementation CreateWorkoutViewController

Workout *workout;

UIAlertController *intervalPickerAlert;

// Used to remove focus from the textfields http://stackoverflow.com/questions/5306240/iphone-dismiss-keyboard-when-touching-outside-of-textfield
UIGestureRecognizer *tapper;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initialize];
    [self initTapper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Initialization

- (void) initialize {
    
    workout = [[Workout alloc] init];
    [self.intervalTableView setDelegate:self];
    [self.intervalTableView setDataSource:self];
    [self updateData];
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

# pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Verify the segue via the identifier
    if ([[segue identifier] isEqualToString:@"CreateWorkoutToAddInterval"]) {
        
        IntervalPickerViewController *destination = segue.destinationViewController;
        
        [destination setDelegate: self];
    }
}

# pragma mark - IBActions

- (IBAction)cancelWorkoutButton:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)saveWorkoutButton:(id)sender {
    
    if ([self validate]) {
        [[WorkoutSvcCache workoutSvcCacheSingleton] createWorkout:workout];
        
        if ([self delegate] != nil) {
            [[self delegate] workoutCreated:workout];
        }
        [self.navigationController popViewControllerAnimated:true];
    }
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [workout.intervals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"WorkoutIntervalCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Interval *interval = [workout.intervals objectAtIndex:indexPath.row];
    cell.textLabel.text = [interval name];
    return cell;
}

# pragma mark - IntervalSelectedDelegate

- (void) selectedInterval:(Interval *) interval {
    
    [workout addInterval:interval];
    [self updateData];
}

# pragma mark - CreateWorkoutViewController

- (void) updateData {
    [self.intervalTableView reloadData];
    [self.workoutDurationLabel setText:[Utilities getHumanReadableDuration:(int)workout.duration]];
}

/**
 *  Validates the inputs before saving. Must be a name and at least one interval.
 *
 *  @return true if the input values are valid, false otherwise
 */
- (bool) validate {
    
    // Must have valid name
    NSString *name = [self.workoutNameTextField text];
    if (name == nil || name.length == 0) {
        return false;
    }
    workout.name = name;
    
    // Must have at least one interval
    if (workout.intervals == nil || ([workout.intervals count] <=0)) {
        return false;
    }
    
    return true;
}

@end
