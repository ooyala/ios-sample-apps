//
//  SampleAppPlayerViewController.h
//  DiscoverySampleApp
//
//  Created on 15/04/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@class PlayerSelectionOption;

@interface SampleAppPlayerViewController : UIViewController

@property (nonatomic) IBOutlet UIView *playerView;
@property (nonatomic) IBOutlet UIButton *button1;
@property (nonatomic) IBOutlet UIButton *button2;
@property (nonatomic) IBOutlet UILabel *switchLabel1;
@property (nonatomic) IBOutlet UILabel *switchLabel2;
@property (nonatomic) IBOutlet UISwitch *switch1;
@property (nonatomic) IBOutlet UISwitch *switch2;
@property (nonatomic) IBOutlet UITextField *text1;
@property (nonatomic) IBOutlet UITextField *text2;

@property (nonatomic) PlayerSelectionOption *playerSelectionOption;

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption;

- (IBAction)onButtonClick:(id)sender;

@end

