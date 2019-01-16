//
//  PlayerViewController.h
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import <OoyalaCastSDK/OOcastManager.h>
#import <OoyalaSDK/OOEmbedTokenGenerator.h>

@class ChromecastPlayerSelectionOption;

@interface PlayerViewController : UIViewController <OOCastManagerDelegate, OOEmbedTokenGenerator>

@property (nonatomic) ChromecastPlayerSelectionOption *mediaInfo;

@end
