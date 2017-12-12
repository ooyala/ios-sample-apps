//
//  OOFullScreenControlsBottomBar.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOFullScreenControlsBottomBarMainControlsView.h"
#import "OOFullScreenControlsBottomBarVolumeView.h"


@interface OOFullScreenControlsBottomBar : UIView

@property (nonatomic) OOFullScreenControlsBottomBarMainControlsView *mainControlsView;
@property (nonatomic) OOFullScreenControlsBottomBarVolumeView *volumeControlsView;

@end
