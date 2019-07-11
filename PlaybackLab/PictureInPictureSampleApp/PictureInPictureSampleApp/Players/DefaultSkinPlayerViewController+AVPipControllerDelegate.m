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
  [self updatePipButtonForStateIsActivated:true];
}

- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
  NSLog(@"✅ pictureInPictureController WillStop PictureInPicture");
  [self updatePipButtonForStateIsActivated:false];
}

#pragma mark - Private methods
// TODO: OS: it's better to change icon on pip-button (via notifying JS about appropriate event) from this place that is triggered by AVPipControllerDelegate.
// But problem is to get access from this VC to *ooReactSkinModel 'OOReactSkinModel (is private property *skinModel in OOSkinViewController, it has APi for interacting with *skinEventsEmitter 'OOReactSkinEventsEmitter' and with *bridge 'RCTBridge' (OOReactSkinBridge))' (path 1) or create new notification in OOyalaSDK, post in here in 'DefaultSkinPlayerViewController (AVPipControllerDelegate)' and listen it in the 'OOSkinPlayerObserver' (path 2, what is too sophisticated solution as for me)

- (void)updatePipButtonForStateIsActivated:(BOOL)isActivated {
  //id params = @{isPipActivatedKey:@(isActivated), isPipButtonVisibleKey:@(true)};
  //[self.skinController.player.bridge.skinEventsEmitter sendDeviceEventWithName:pipEventKey body:params];
}

@end
