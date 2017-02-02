//
//  OOPulsePlayerOptions.h
//  OoyalaSDK
//
//  Created by Mehdi Dadash Pour on 09/11/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The OOPulsePlayerOptions allows you to display or hide the ad title while using
    the OOPulseManager.
 */
@class OOPulsePlayerOptions;

@interface OOPulsePlayerOptions : NSObject

@property (nonatomic,assign) BOOL displayingAdTitle;

/**
 *  Initialize the OOPulsePlayerOption.
 *
 *  @param displayingAdTitle The option to whether display or hide the ad title.
 *
 *  @return The OOPulsePlayerOptions instance.
 */
- (instancetype)init;

@end
