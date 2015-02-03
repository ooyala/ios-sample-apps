/**
 * @class      BasicSampleAppPlayerViewController BasicSampleAppPlayerViewController.m "BasicSampleAppPlayerViewController.m"
 * @brief      An abstract ViewController which is used as the outlet for all Player nibs
 * @details    An abstract ViewController which is used as the outlet for all Player nibs.  Subclass this whenever you develop a new player.
               When creating a new PlayerViewControler, use this as your superclass.
               When creating a new nib, use this class as your owner
 * @date       01/12/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "BasicSampleAppPlayerViewController.h"

@implementation BasicSampleAppPlayerViewController

- (id)initWithPlayerSelectionOption:(BasicPlayerSelectionOption *)playerSelectionOption {
  self = [super init];
  if (self) {
    self.playerSelectionOption = playerSelectionOption;
  }
  return self;
}

- (IBAction)onButtonClick:(id)sender {}
@end
