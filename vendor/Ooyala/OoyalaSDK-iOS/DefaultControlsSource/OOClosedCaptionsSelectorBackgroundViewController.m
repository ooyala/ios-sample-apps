//
//  OOClosedCaptionsSelectorBackgroundViewController.m
//  OoyalaSDK
//
//  Created by Liusha Huang on 2/28/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//


/*
 * presentViewController for iPhone will always be fullscreen mode. In order to add title and navigation bar to
 * UITableViewController I add this UIViewController as background to hold both OOClosedCaptionsSelectorViewController
 * and the UIToolBar
 */

#import "OOClosedCaptionsSelectorBackgroundViewController.h"
#import "OOClosedCaptionsSelectorViewController.h"
#import "OOOoyalaPlayerViewController.h"

@interface OOClosedCaptionsSelectorBackgroundViewController ()
@property (nonatomic, strong) OOClosedCaptionsSelectorViewController* selectorController;
@property (nonatomic, strong) UIToolbar* navigationBar;
@end

@implementation OOClosedCaptionsSelectorBackgroundViewController

-(id) initWithSelectorView:(OOClosedCaptionsSelectorViewController*) selectorController {
  self = [super init];
  self.selectorController = selectorController;

  // try to have navigationBar look good on both iOS 6 and 7.
  CGFloat vsize = (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) ? 44 : 60;

  self.navigationBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, vsize)];
  self.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:self.navigationBar];


  NSString* doneButtonTitle = [[OOOoyalaPlayerViewController currentLanguageSettings] objectForKey:@"Done"];
  UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:doneButtonTitle
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self.selectorController action:@selector(dismiss)];

  UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, vsize)];
  label.text = @"Subtitles";
  [label setFont:[UIFont fontWithName:@"Verdana-Bold" size:18]];
  label.backgroundColor = [UIColor clearColor];

  UIBarButtonItem* toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];

  UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

  UIBarButtonItem* fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  fixedSpace.width = 0; // The size between Done button and right edge

  NSArray* items = [[NSArray alloc] initWithObjects:flexibleSpace, toolBarTitle, flexibleSpace, doneButton, fixedSpace, nil];
  [self.navigationBar setItems:items];

  [self addChildViewController:self.selectorController];
  [self.view addSubview:selectorController.view];
  [self.selectorController.view setFrame:CGRectMake(0, vsize, self.view.frame.size.width, self.view.frame.size.height - vsize)];
  return self;
}
@end
