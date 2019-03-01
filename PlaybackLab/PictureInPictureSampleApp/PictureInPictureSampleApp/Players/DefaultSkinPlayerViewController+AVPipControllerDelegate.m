//
//  DefaultSkinPlayerViewController+AVPipControllerDelegate.m
//  PictureInPictureSampleApp
//
//  Copyright (c) 2019 Ooyala, Inc. All rights reserved.
//

#import "DefaultSkinPlayerViewController+AVPipControllerDelegate.h"

@implementation DefaultSkinPlayerViewController (AVPipControllerDelegate)

- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
  NSLog(@"✅ pictureInPictureControllerWillStopPictureInPicture");
}

@end
