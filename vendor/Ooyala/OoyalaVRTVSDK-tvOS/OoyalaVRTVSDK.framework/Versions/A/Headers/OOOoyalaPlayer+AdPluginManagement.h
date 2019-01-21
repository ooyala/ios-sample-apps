//
//  OOOoyalaPlayer+AdPluginManagement.h
//  OoyalaSDK
//
//  Created on 10/31/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"
#import "OOAdPluginManagerProtocol.h"

#ifndef OOOoyalaPlayer_AdPluginManagement_h
#define OOOoyalaPlayer_AdPluginManagement_h

@class OOStateNotifier;
@class OOOoyalaAdPlayer;

@interface OOOoyalaPlayer (AdPluginManagement)<OOAdPluginManagerProtocol>

/**
 * Register ad player for an ad type
 * @param[in] adPlayerClass the ad player class
 * @param[in] adClass the ad class
 */
- (void)registerAdPlayer:(Class)adPlayerClass forType:(Class)adClass;

/**
 * Called by an ad plugin to create a state notifier
 *
 */
- (OOStateNotifier *)createStateNotifier;

@end

#endif /* OOOoyalaPlayer_AdPluginManagement_h */
