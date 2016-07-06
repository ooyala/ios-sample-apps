//
//  OOSkinViewController.h
//  OoyalaSkin
//
//  Created by Zhihui Chen on 4/16/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OOOoyalaPlayer;
@class OOSkinOptions;
@class OOClosedCaptionsStyle;

@interface OOSkinViewController : UIViewController

@property (nonatomic, readonly) OOOoyalaPlayer *player;
@property (nonatomic, readonly) OOSkinOptions *skinOptions;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) OOClosedCaptionsStyle *closedCaptionsDeviceStyle;

- (instancetype) init __attribute__((unavailable("init not available")));
- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player
                   skinOptions:(OOSkinOptions *)jsCodeLocation
                        parent:(UIView *)parentView
                 launchOptions:(NSDictionary *)options;

- (void)ccStyleChanged:(NSNotification *) notification;
@end
