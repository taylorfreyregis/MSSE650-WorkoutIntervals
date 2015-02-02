//
//  CreateWorkoutViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "CreateWorkoutViewController.h"
#import "Interval.h"

@interface CreateWorkoutViewController ()

@end

@implementation CreateWorkoutViewController


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

#pragma mark - Workout

- (IBAction)setDurationButton:(id)sender {
    //Open spinner with durations
}

- (IBAction)cancelWorkoutButton:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)addIntervalButton:(id)sender {
    // Open spinner and add selected one to the list of Intervals stored within the Workout
}

- (IBAction)saveWorkoutButton:(id)sender {
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.intervalSvcCache retrieveAllIntervals] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Interval *interval = [[self.intervalSvcCache retrieveAllIntervals] objectAtIndex:indexPath.row];
    cell.textLabel.text = [interval description];
    return cell;
}

@end
