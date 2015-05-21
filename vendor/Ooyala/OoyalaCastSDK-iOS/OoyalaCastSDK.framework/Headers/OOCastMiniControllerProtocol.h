//
//  OOCastMiniControllerProtocol.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 9/9/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OoyalaSDK/OOPlayerProtocol.h>

@class OOChromecastPlugin;

@protocol OOCastMiniControllerProtocol <NSObject>

/**
 * This is called when the play/pause button need to update by OOCastPlugin
 * Show pause button if the given state is OOOoyalaPlayerStatePlaying
 */
- (void)updatePlayState:(BOOL)isPlaying;

/**
 * This is called when we disconnect from the chromecast device
 */
- (void)dismiss;
@end
