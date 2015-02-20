//
//  WorkoutsTableViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WorkoutsTableViewController.h"
#import "PerformWorkoutViewController.h"
#import "Workout.h"
//#import "WorkoutSvcArchive.h"
#import "WorkoutDatabaseSvc.h"

@interface WorkoutsTableViewController ()

@end

@implementation WorkoutsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = false;
    _workouts = [NSMutableArray arrayWithArray:[[WorkoutDatabaseSvc workoutSvcSingleton] retrieveAllWorkouts]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_workouts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"WorkoutIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Workout *workout = [_workouts objectAtIndex:indexPath.row];
    cell.textLabel.text = workout.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"WorkoutsTableToPerformWorkout" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Verify the segue via the identifier
    if ([[segue identifier] isEqualToString:@"WorkoutsToCreateWorkout"]) {
        
        CreateWorkoutViewController *destination = segue.destinationViewController;
        
        [destination setDelegate: self];
    } else if ([[segue identifier] isEqualToString:@"WorkoutsTableToPerformWorkout"]) {
        PerformWorkoutViewController *destination = segue.destinationViewController;
        
        Workout *workout = [_workouts objectAtIndex:[[self tableView] indexPathForSelectedRow].row];
        
        destination.workout = workout;
    }
}

# pragma mark - IBActions

- (IBAction)doneButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}

# pragma mark - WorkoutCreatedDelegate

- (void) workoutCreated:(Workout *) workout {
    
    // No longer necessary now that we are pulling out of a central repo? aka SQL
    [self updateData];
}

# pragma mark - WorkoutsTableViewController

- (void) updateData {
    
//    [self.workoutTableView reloadData];
}

@end
