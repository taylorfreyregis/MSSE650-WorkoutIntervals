//
//  CreateIntervalViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 1/25/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "CreateIntervalViewController.h"
#import "IntervalSvcCache.h"

@interface CreateIntervalViewController ()

@end

@implementation CreateIntervalViewController

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

# pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[IntervalSvcCache intervalIncrements] count];
}

# pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[IntervalSvcCache intervalIncrements] objectEnumerator]
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

# pragma mark - Interval

- (IBAction)intervalSetDuration:(id)sender {
    // Open a spinner for duration, same as the one for workout duration
}

- (IBAction)saveIntervalButton:(id)sender {
    // Save to IntervalService
    // TODO how to pass around a reference to the single service? Do you override the init or just getter/setter?
}

- (IBAction)cancelIntervalButton:(id)sender {
    // Cancel. Just pop the navigation stack
    [self.navigationController popViewControllerAnimated:true];
}

- (bool) validate {
    
    NSString *name = [self.intervalNameTextField text];
    
    if (name == nil || name.length == 0) {
        return false;
    }
    
    return true;
}

@end
