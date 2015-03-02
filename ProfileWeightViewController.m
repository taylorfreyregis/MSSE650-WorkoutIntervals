//
//  ProfileWeightViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 3/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "ProfileWeightViewController.h"
#import "Constants.h"

@interface ProfileWeightViewController ()

@end

@implementation ProfileWeightViewController

UIGestureRecognizer *tapper;

NSMutableDictionary *weights;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    [self initTapper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Initialization

- (void) initialize {
    
    [self.profileWeightTableView setDelegate:self];
    [self.profileWeightTableView setDataSource:self];
    
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

- (void) initNumericTextField {
    
    // Set the delegate to be able to prevent/validate numeric only textfields
    [self.profileWeightTextField setDelegate:self];
    
    // Number keyboard
    [self.profileWeightTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    // Initial Value
    self.profileWeightTextField.text = @"0";
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [weights count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"ProfileWeightCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *key = [weights allKeys][indexPath.row];
    
    NSString *weightValue = [NSString stringWithFormat:@"%ld", [weights[key] integerValue]];
    NSString *weightDate = key;
    cell.textLabel.text  = weightValue;
    cell.detailTextLabel.text  = weightDate;
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

# pragma mark - UITextFieldDelegate

// Forces numeric values
- (BOOL) textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange) range replacementString:(NSString *) string {
    
    if (textField == self.profileWeightTextField) {
        
        // Numeric hours ( < 24) only
        
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:NUMERIC_VALUES] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
        
    }
    
    // Default behavior
    return true;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    // Should we wish to enforce a range, here would it go
    
    // Dismiss keyboard
    [textField resignFirstResponder];
}

# pragma mark - CreateWorkoutViewController

- (void) updateData {
    weights = [[ProfileDatabaseSvc profileSvcSingleton] retrieveAllWeightsForProfile:self.profile];
    [self.profileWeightTableView reloadData];
}

/**
 *  Validates the inputs before saving. Must be a name and at least one interval.
 *
 *  @return true if the input values are valid, false otherwise
 */
- (bool) validate {
    
    int weight = [self.profileWeightTextField.text intValue];
    
    if (weight <= 0) {
        return false;
    }
    
    return true;
}

#pragma mark - IBAction

- (IBAction)addWeightToProfile:(id)sender {
    
    if ([self validate]) {
        int weight = [self.profileWeightTextField.text intValue];
        
        [[ProfileDatabaseSvc profileSvcSingleton] addWeightMeasurement:weight ForProfile:self.profile];
    }
    
    [self updateData];
}
@end
