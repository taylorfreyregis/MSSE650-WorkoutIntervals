//
//  PerformWorkoutViewController.m
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "PerformWorkoutViewController.h"
#import "Utilities.h"
#import "IntervalModel.h"

@interface PerformWorkoutViewController ()

@end

@implementation PerformWorkoutViewController

NSDate *timeStarted;
NSTimer *timer;
int timeRemaining;
int timeElapsed;
bool isRunning;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.workout.name;
    [self resetTimerViews];
    
    self.startButtonOutlet.enabled = true;
    self.finishButtonOutlet.enabled = false;
    
    [self.intervalsTableView setDataSource:self];
    [self.intervalsTableView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetTimerViews {
    timeElapsed = 0;
    [self.elapsedTimeLabel setText:[Utilities getHumanReadableDuration:(int)timeElapsed]];
    
    timeRemaining = self.workout.duration;
    [self.remainingTimeLabel setText:[Utilities getHumanReadableDuration:(int)timeRemaining]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.workout.intervals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"PerformWorkoutInterval";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    IntervalModel *interval = [self.workout.intervals objectAtIndex:indexPath.row];
    cell.textLabel.text = [interval name];
    return cell;
}


#pragma mark - WorkoutLogic

- (void) updateCounters:(NSTimer *)timer {
    
    timeRemaining--;
    timeElapsed++;
    
    [self.remainingTimeLabel setText:[Utilities getHumanReadableDuration:(int)timeRemaining]];
    [self.elapsedTimeLabel setText:[Utilities getHumanReadableDuration:(int)timeElapsed]];
    
    if (timeRemaining <= 0) {
        [timer invalidate];
        
    }
    
}

#pragma mark - IBActions

- (IBAction)startButtonAction:(id)sender {
    [self startTimer];
    isRunning = true;
    self.startButtonOutlet.enabled = false;
    self.finishButtonOutlet.enabled = true;
    self.pauseContinueButtonOutlet.titleLabel.text = @"Pause";
}

-(void) startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounters:) userInfo:nil repeats:true];
}

- (IBAction)pauseContinueButtonAction:(id)sender {
    if (isRunning) {
        isRunning = false;
        [timer invalidate];
        self.pauseContinueButtonOutlet.titleLabel.text = @"Continue";
    } else {
        isRunning = true;
        [self startTimer];
        self.pauseContinueButtonOutlet.titleLabel.text = @"Pause";
    }
}

- (IBAction)finishButtonAction:(id)sender {
    self.startButtonOutlet.enabled = true;
    self.finishButtonOutlet.enabled = false;
    [timer invalidate];
    [self resetTimerViews];
}

@end
