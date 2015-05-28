//
//  PlayerViewController.h
//  ChromecastSampleApp
//
//  Created by Liusha Huang on 9/18/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaCastSDK/OOcastManager.h>

@interface PlayerViewController : UIViewController <OOCastManagerDelegate>
@property (strong, nonatomic) NSDictionary *mediaInfo;
@end
