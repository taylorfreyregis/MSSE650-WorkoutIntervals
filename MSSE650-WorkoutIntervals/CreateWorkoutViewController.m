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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    workout = [[Workout alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Initialization

//- (void) createAndShowAlert {
//    intervalPickerAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    UIAlertAction* addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//        
//        [intervalPickerAlert dismissViewControllerAnimated:YES completion:nil];
//    }];
//    
//    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//        [intervalPickerAlert dismissViewControllerAnimated:YES completion:nil];
//    }];
//    
//    [intervalPickerAlert addAction:addAction];
//    [intervalPickerAlert addAction:cancelAction];
//    
////    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(-8, self.view.center.y-100, self.view.frame.size.width, 200)];
////    UIPickerView *pickerView = [[UIPickerView alloc] init];
////    pickerView.center = self.view.center;
//    
//    CGRect pickerFrame = CGRectMake(-8, 0, self.view.frame.size.width, 100);
//    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
//    
//    [pickerView setShowsSelectionIndicator:YES];
//    
//    pickerView.delegate = self;
//    pickerView.dataSource = self;
//    
//    [intervalPickerAlert.view addSubview:pickerView];
//    [self presentViewController:intervalPickerAlert animated:true completion:nil];
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"prepareForSegue.. CREATE WORKOUT!!! source: %@, destination: %@", segue.sourceViewController, segue.destinationViewController);
}


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
    return [workout.intervals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Interval *interval = [workout.intervals objectAtIndex:indexPath.row];
    cell.textLabel.text = [interval description];
    return cell;
}

@end
