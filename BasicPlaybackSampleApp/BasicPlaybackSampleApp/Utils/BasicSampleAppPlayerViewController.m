/**
 * @class      BasicSampleAppPlayerViewController BasicSampleAppPlayerViewController.m "BasicSampleAppPlayerViewController.m"
 * @brief      An abstract ViewController which is used as the outlet for all Player nibs
 * @details    An abstract ViewController which is used as the outlet for all Player nibs.  Subclass this whenever you develop a new player.
               When creating a new PlayerViewControler, use this as your superclass.
               When creating a new nib, use this class as your owner
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "BasicSampleAppPlayerViewController.h"

@implementation BasicSampleAppPlayerViewController
- (IBAction)playAdsEmbedCode:(UIButton *)sender {
  [self.ooyalaPlayerViewController.player setEmbedCode:self.adsEmbedcodeList[self.selectedRow]];
}

- (id)initWithPlayerSelectionOption:(BasicPlayerSelectionOption *)playerSelectionOption {
  self = [super init];
  if (self) {
    self.playerSelectionOption = playerSelectionOption;
  }
  return self;
}

- (IBAction)onButtonClick:(id)sender {}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [self.adsList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [self.adsList objectAtIndex:row];
}

#pragma mark -
#pragma mark PickerView Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
  _selectedRow = row;
  
}

@end
