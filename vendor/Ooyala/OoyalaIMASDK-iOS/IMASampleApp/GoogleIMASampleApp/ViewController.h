//
//  ViewController.h
//  GoogleIMASampleApp
//
//  Created by Ryan Chen on 7/23/13.
//  Copyright (c) 2013 Ryan Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) IBOutlet UIView *videoView;
@property (nonatomic) IBOutlet UIView *smallerCompanionSlot;
@property (nonatomic) IBOutlet UIView *largerCompanionSlot;
@property (nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic) IBOutlet UIButton *button;

- (IBAction)setEC:(id)sender;

@end
