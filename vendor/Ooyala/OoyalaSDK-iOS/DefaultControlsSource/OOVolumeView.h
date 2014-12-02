/**
 * @class      OOVolumeView OOVolumeView.h "OOVolumeView.h"
 * @brief      OOVolumeView
 * @details    OOVolumeView.h in OoyalaSDK
 * @date       1/9/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface OOVolumeView : UIView

@property (nonatomic) UIToolbar *toolbar;

@property (nonatomic) MPVolumeView *volumeSlider;

@end
