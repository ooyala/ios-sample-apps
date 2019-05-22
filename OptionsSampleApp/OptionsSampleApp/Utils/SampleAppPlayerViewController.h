/**
 * @class      SampleAppPlayerViewController SampleAppPlayerViewController.h "SampleAppPlayerViewController.h"
 * @brief      An abstract ViewController which is used as the outlet for all Player nibs
 * @details    An abstract ViewController which is used as the outlet for all Player nibs.  Subclass this whenever you develop a new player.
 *             When creating a new PlayerViewControler, use this as your superclass.
 *             When creating a new nib, use this class as your owner
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

@import UIKit;

@class PlayerSelectionOption;

@interface SampleAppPlayerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel1;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel2;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;
@property (nonatomic) IBOutlet UIStackView *stackView1;
@property (weak, nonatomic) IBOutlet UIView *playerView1;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic) BOOL qaModeEnabled;
@property (nonatomic) PlayerSelectionOption *playerSelectionOption;

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled;

- (IBAction)onButtonClick:(id)sender;

@end

