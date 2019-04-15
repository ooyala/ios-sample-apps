//
//  FullscreenStateController.h
//  OoyalaSkinSDK
//
//  Copyright © 2018 ooyala. All rights reserved.
//

@import Foundation;

@class UIView;
@class UIViewController;

@interface FullscreenStateController : NSObject

- (nonnull instancetype)initWithParentView:(nonnull UIView *)parentView
                             containerView:(nonnull UIView *)containerView
                                 videoView:(nonnull UIView *)videoView
               andFullscreenViewController:(nonnull UIViewController *)fullscreenViewController;

- (void)setFullscreen:(BOOL)fullscreen
withOrientaionChanges:(BOOL)isOrientaionChanges
           completion:(nullable void (^)(void))completion;
- (void)viewWillTransition:(BOOL)isAutoFullscreenWithRotatedEnabled;

@end
