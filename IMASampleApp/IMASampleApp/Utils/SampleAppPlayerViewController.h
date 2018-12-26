/**
 * @class      SampleAppPlayerViewController SampleAppPlayerViewController.h "SampleAppPlayerViewController.h"
 * @brief      An abstract ViewController which is used as the outlet for all Player nibs
 * @details    An abstract ViewController which is used as the outlet for all Player nibs.  Subclass this whenever you develop a new player.
 *             When creating a new PlayerViewControler, use this as your superclass.
 *             When creating a new nib, use this class as your owner
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "PlayerSelectionOption.h"

@interface SampleAppPlayerViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *playerView;
@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UILabel *switchLabel1;
@property (nonatomic, weak) IBOutlet UILabel *switchLabel2;
@property (nonatomic, weak) IBOutlet UISwitch *switch1;
@property (nonatomic, weak) IBOutlet UISwitch *switch2;
@property (nonatomic, weak) IBOutlet UITextField *text1;
@property (nonatomic, weak) IBOutlet UITextField *text2;
@property (nonatomic, weak) IBOutlet UIStackView *stackView1;
@property (nonatomic, weak) IBOutlet UIView *playerView1;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@property (strong, nonatomic) PlayerSelectionOption *playerSelectionOption;
@property (nonatomic) BOOL qaModeEnabled;

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled;

- (IBAction)onButtonClick:(id)sender;

@end

