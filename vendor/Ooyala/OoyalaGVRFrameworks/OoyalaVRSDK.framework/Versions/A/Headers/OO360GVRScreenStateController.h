//
//  OO360GVRScreenStateController.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol OO360GVRScreenStateControllerDelegate <NSObject>

@optional

/** Called when the device orientation did changed. */
- (void)didInterfaceOrientationChanged;

/** Called when the player enter fullscreen. */
- (void)didEnterFullscreen;

/** Called when the player exit from fullscreen. */
- (void)didExitFullscreen;

@end


@interface OO360GVRScreenStateController : NSObject

@property(nonatomic, weak) id<OO360GVRScreenStateControllerDelegate> delegate;

/** State of fullscreen mode. */
@property(nonatomic, readonly) BOOL fullScreenEnabled;

@end
