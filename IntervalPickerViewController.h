//
//  IntervalPickerViewController.h
//  MSSE650-WorkoutIntervals
//
//  Created by Taylor Frey on 2/8/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntervalPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

- (IBAction)addIntervalAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
