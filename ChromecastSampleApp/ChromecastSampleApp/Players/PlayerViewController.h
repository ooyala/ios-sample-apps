//
//  PlayerViewController.h
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaCastSDK/OOcastManager.h>

@class ChromecastPlayerSelectionOption;

@interface PlayerViewController : UIViewController <OOCastManagerDelegate, OOEmbedTokenGenerator>

@property (strong, nonatomic) ChromecastPlayerSelectionOption *mediaInfo;

@end
