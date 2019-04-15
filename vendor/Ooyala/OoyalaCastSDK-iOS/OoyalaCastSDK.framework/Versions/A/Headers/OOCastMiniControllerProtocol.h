//
//  OOCastMiniControllerProtocol.h
//  OoyalaSDK
//
//  Created on 9/9/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

@import Foundation;

/**
 @protocol OOCastMiniControllerProtocol

 Should maintain a @c OOCastMiniControllerDelegate.
 */
@protocol OOCastMiniControllerProtocol <NSObject>
/**
 This is called when the play/pause button need to update by @c OOCastManager

 @param isPlaying @c YES if state is playing
 */
- (void)updatePlayState:(BOOL)isPlaying;

/**
 This is called when we disconnect from the chromecast device.

 Can also be used to explicitly remove the MiniController.

 This should call
 @code
 [delegate miniControllerDidDismiss:]
 @endcode
 as well.
 */
- (void)dismiss;

@end
