//
//  OOFairplayContentKeyDelegate.h
//  OoyalaSDK
//
//  Created on 11/3/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

/**
 @protocol OOFairplayContentKeyDelegate
 
 This delegate communicates about downloading a Fairplay license.
 
 \ingroup offline
 */
@protocol OOFairplayContentKeyDelegate

/**
 If there was an error retrieving a Fairplay key from the server, this method will be called.
 
 @param error description of what went wrong.
 */
- (void)contentKeyFailedToRetriveWithError:(NSError *)error;

/**
 If we intent to download the Fairplay asset, this will be called after saving the Fairplay key retrieved from the server.
 
 @param location where it was persisted in the device.
 @param asset the asset that will be downloaded.
 */
- (void)contentKeyPersistedAtLocation:(NSURL *)location forAsset:(AVURLAsset *)asset;

@end
