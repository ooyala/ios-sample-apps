//
//  OOPulsePlayerOptions.h
//  OoyalaPulseIntegration
//
//  Created on 09/11/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

@import Foundation;

/**
 The @c OOPulsePlayerOptions allows you to display or hide the ad title while using
 the @c OOPulseManager.
 */
@class OOPulsePlayerOptions;

@interface OOPulsePlayerOptions : NSObject

@property (nonatomic) BOOL displayingAdTitle;

/**
 Initialize the OOPulsePlayerOption.
 @return The OOPulsePlayerOptions instance.
 */
- (instancetype)init;

@end
