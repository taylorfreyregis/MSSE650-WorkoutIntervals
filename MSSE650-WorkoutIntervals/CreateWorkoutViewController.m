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
    [self.intervalTableView reloadData];    
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

# pragma mark - Workout

- (IBAction)setDurationButton:(id)sender {
    //Open spinner with durations
}

- (IBAction)cancelWorkoutButton:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)saveWorkoutButton:(id)sender {
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
    [self.intervalTableView reloadData];
}

@end
