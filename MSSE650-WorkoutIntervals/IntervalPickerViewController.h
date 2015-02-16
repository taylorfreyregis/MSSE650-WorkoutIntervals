//
//  IntervalPickerViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interval.h"

@protocol IntervalSelectedDelegate <NSObject>

@required
- (void) selectedInterval:(Interval *) interval;

@end

@interface IntervalPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *intervalPickerView;

@property (nonatomic) id<IntervalSelectedDelegate> delegate;

- (IBAction)addIntervalAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
