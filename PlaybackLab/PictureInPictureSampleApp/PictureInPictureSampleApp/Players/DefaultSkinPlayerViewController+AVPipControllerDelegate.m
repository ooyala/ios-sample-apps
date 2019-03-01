//
//  DefaultSkinPlayerViewController+AVPipControllerDelegate.m
//  PictureInPictureSampleApp
//
//  Copyright (c) 2019 Ooyala, Inc. All rights reserved.
//

#import "DefaultSkinPlayerViewController+AVPipControllerDelegate.h"

@implementation DefaultSkinPlayerViewController (AVPipControllerDelegate)

#pragma mark - AVPictureInPictureControllerDelegate

- (void)pictureInPictureControllerDidStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
  NSLog(@"✅ pictureInPictureController DidStart PictureInPicture");
}

- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
  NSLog(@"✅ pictureInPictureController WillStop PictureInPicture");
}

@end
