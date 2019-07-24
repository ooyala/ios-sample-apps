//
//  OOFullScreenControlsBottomBar.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@class OOFullScreenControlsBottomBarMainControlsView;
@class OOFullScreenControlsBottomBarVolumeView;

@interface OOFullScreenControlsBottomBar : UIView

@property (nonatomic) OOFullScreenControlsBottomBarMainControlsView *mainControlsView;
@property (nonatomic) OOFullScreenControlsBottomBarVolumeView *volumeControlsView;

@end
