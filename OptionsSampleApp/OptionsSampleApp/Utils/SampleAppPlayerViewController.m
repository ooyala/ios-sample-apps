/**
 * @class      SampleAppPlayerViewController SampleAppPlayerViewController.m "SampleAppPlayerViewController.m"
 * @brief      An abstract ViewController which is used as the outlet for all Player nibs
 * @details    An abstract ViewController which is used as the outlet for all Player nibs.  Subclass this whenever you develop a new player.
 When creating a new PlayerViewControler, use this as your superclass.
 When creating a new nib, use this class as your owner
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "SampleAppPlayerViewController.h"

@implementation SampleAppPlayerViewController

- (instancetype)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption
                                qaModeEnabled:(BOOL)qaModeEnabled {
  if (self = [super init]) {
    _playerSelectionOption = playerSelectionOption;
    _qaModeEnabled = qaModeEnabled;
  }
  return self;
}

- (IBAction)onButtonClick:(id)sender {}

@end
