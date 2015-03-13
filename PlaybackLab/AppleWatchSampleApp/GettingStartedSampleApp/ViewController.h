//
//  ViewController.h
//  GettingStartedSampleApp
//
//  Created by Chris Leonavicius on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OOOoyalaPlayerViewController;

@interface ViewController : UIViewController


@property (nonatomic, strong) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic, retain) IBOutlet UITextView* textView;

- (void)play;
- (void)pause;
- (CGFloat)getPlayheadTime;
@end
