//
//  OOCastMiniControllerProtocol.h
//  OoyalaSDK
//
//  Created on 9/9/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Should maintain a OOCastMiniControllerDelegate.
 */
@protocol OOCastMiniControllerProtocol <NSObject>

/**
 This is called when the play/pause button need to update by OOCastManager

 @param isPlaying YES if state is playing
 */
- (void)updatePlayState:(BOOL)isPlaying;

/**
 This is called when we disconnect from the chromecast device.
 Can also be used e.g. by app code to explicitly remove the MiniController.
 This should call [delegate onDismissMiniController:] as well.
 */
- (void)dismiss;

@end
