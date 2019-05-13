//
//  SkinCastPlaybackView.h
//  ChromecastSampleApp
//
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

@import UIKit;
@class OOVideo;

@interface SkinCastPlaybackView : UIImageView

- (instancetype)init __attribute__((unavailable("init")));
- (instancetype)initWithFrame:(CGRect)frame;// __attribute__((unavailable("initWithFrame:")));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder:")));
- (instancetype)initWithImage:(UIImage *)image __attribute__((unavailable("initWithImage:")));
- (void)configureCastPlaybackViewBasedOnItem:(OOVideo *)item;

@end

