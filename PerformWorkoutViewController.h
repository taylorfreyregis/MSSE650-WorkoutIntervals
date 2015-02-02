//
//  PerformWorkoutViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/1/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@interface PerformWorkoutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *workoutTitle;

@property (nonatomic) Workout *workout;

@end
