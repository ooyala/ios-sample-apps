//
//  ViewController.m
//  GoogleIMASampleApp
//
//  Created by Ryan Chen on 7/23/13.
//  Copyright (c) 2013 Ryan Chen. All rights reserved.
//

#import "ViewController.h"
#import "OOOoyalaPlayerViewController.h"
#import "OOOoyalaPlayer.h"
#import "OOIMAManager.h"
#import "OOPlayerDomain.h"

@interface ViewController ()
@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) OOIMAManager *adsManager;
@property (nonatomic) NSMutableArray *testList;
@property (nonatomic) NSString *currentEmbedCode;
@end

@implementation ViewController

@synthesize ooyalaPlayerViewController;

NSString *const PCODE        = @"Vpd3E6BNabnn09G72IWye5O2RzN1";
NSString *const EMBEDCODE    = @"Q5MXg2bzq0UAXXMjLIFWio_6U0Jcfk6v";
NSString *const PLAYERDOMAIN = @"http://www.ooyala.com";

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

	ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPcode:PCODE domain:[[OOPlayerDomain alloc] initWithString:PLAYERDOMAIN]];

  // Setup video view
  [ooyalaPlayerViewController.view setFrame:self.videoView.bounds];
  [self addChildViewController:ooyalaPlayerViewController];

  [self.videoView addSubview:ooyalaPlayerViewController.view];
  
  self.adsManager = [[OOIMAManager alloc] initWithOoyalaPlayerViewController:ooyalaPlayerViewController];

  // Setup a companion ad view
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    [self.adsManager addCompanionSlot:_largerCompanionSlot];
  }
  [self.adsManager addCompanionSlot:_smallerCompanionSlot];

  self.testList = [[NSMutableArray alloc] init];
  [self.testList addObject: [NSArray arrayWithObjects:@"Ad-Rules Preroll", @"EzZ29lcTq49IswgZYkMknnU4Ukb9PQMH", nil]];
  [self.testList addObject: [NSArray arrayWithObjects:@"Ad-Rules Midroll", @"VlaG9lcTqeUU18adfd1DVeQ8YekP3H4l", nil]];
  [self.testList addObject: [NSArray arrayWithObjects:@"Ad-Rules Postroll",	@"BnaG9lcTqLXQNyod7ON8Yv3eDas2Oog6", nil]];
  [self.testList addObject: [NSArray arrayWithObjects:@"Podded Preroll", @"1wNjE3cDox0G3hQIWxTjsZ8MPUDLSkDY", nil]];
  [self.testList addObject: [NSArray arrayWithObjects:@"Podded Midroll", @"1yNjE3cDodUEfUfp2WNzHkCZCMb47MUP", nil]];
  [self.testList addObject: [NSArray arrayWithObjects:@"Podded Postroll", @"1sNjE3cDoN3ZewFm1238ce730J4BMrEJ", nil]];
  [self.testList addObject: [NSArray arrayWithObjects:@"Podded Pre-Mid-Post", @"ZrOTE3cDoXo2sLOWzQPxjS__M-Qk32Co", nil]];

  // 3.0.0+: Ads cannot be skipped due to a bug in Google IMA's Libraries
  [self.testList addObject: [NSArray arrayWithObjects:@"Skippable", @"FhbGRjbzq8tfaoA3dhfxc2Qs0-RURJfO", nil]];
  [self.testList addObject: [NSArray arrayWithObjects:@"Pre, Mid and Post Skippable", @"10NjE3cDpj8nUzYiV1PnFsjC6nEvPQAE", nil]];

  _pickerView.delegate = self;
  _pickerView.dataSource = self;
  _pickerView.showsSelectionIndicator = YES;
  [_pickerView reloadAllComponents];
  [_pickerView selectRow:0 inComponent:0 animated:NO];
  self.currentEmbedCode = [[self.testList objectAtIndex:0] objectAtIndex:1];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [_testList count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
  NSArray *item = [_testList objectAtIndex:row];
  return [item objectAtIndex:0];
}


#pragma mark -
#pragma mark PickerView Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
  self.currentEmbedCode = [[self.testList objectAtIndex:row] objectAtIndex:1];
}

- (IBAction)setEC:(id)sender {  [self.adsManager setAdTagParameters:nil];
  [ooyalaPlayerViewController.player setEmbedCode:self.currentEmbedCode];
}

@end
