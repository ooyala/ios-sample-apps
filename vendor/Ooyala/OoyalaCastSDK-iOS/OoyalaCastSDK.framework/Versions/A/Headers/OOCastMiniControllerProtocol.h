//
//  OOCastMiniControllerProtocol.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 9/9/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOCastManager;
@class OOCastMiniControllerView;

/**
 * Should maintain a OOCastMiniControllerDelegate.
 */
@protocol OOCastMiniControllerProtocol <NSObject>

/**
 * This is called when the play/pause button need to update by OOCastManager
 * Show pause button if the given state is OOOoyalaPlayerStatePlaying
 */
- (void)updatePlayState:(BOOL)isPlaying;

/**
 * This is called when we disconnect from the chromecast device.
 * Can also be used e.g. by app code to explicitly remove the MiniController.
 * This should call [delegate onDismissMiniController:] as well.
 */
- (void)dismiss;
@end

@protocol OOCastMiniControllerDelegate <NSObject>
-(void)onDismissMiniController:(id<OOCastMiniControllerProtocol>)miniControllerView;
@end
