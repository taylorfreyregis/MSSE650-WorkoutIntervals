//
//  IntervalPickerViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "IntervalPickerViewController.h"
#import "IntervalSvcCoreData.h"

@interface IntervalPickerViewController ()

@end

@implementation IntervalPickerViewController 

Interval *currentlySelectedInterval;
NSMutableArray *intervals;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    intervals = [[IntervalSvcCoreData intervalSvcSingleton] retrieveAllIntervals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
//    int numOfRows = (int)[[[IntervalSvcArchive intervalSvcSingleton] retrieveAllIntervals] count];
    
    return intervals.count;
}

# pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    NSString *display = [[[[IntervalSvcArchive intervalSvcSingleton] retrieveAllIntervals] objectAtIndex:row] name];
    NSString *display = [[intervals objectAtIndex:row] name];
    return display;
}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    
//    //    currentlySelectedInterval = [[[IntervalSvcArchive intervalSvcSingleton] retrieveAllIntervals] objectAtIndex:row];
//        currentlySelectedInterval = [intervals objectAtIndex:row];
//}

/*
 # pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
*/

# pragma mark - IBActions

- (IBAction)addIntervalAction:(id)sender {
    
    if ([self delegate] != nil) {
        int selectedRow = (int)[self.intervalPickerView selectedRowInComponent:0];
        if (selectedRow == -1) {
            selectedRow = 0;
        }
        [[self delegate] selectedInterval:[intervals objectAtIndex:selectedRow]];
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)cancelAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}
@end
