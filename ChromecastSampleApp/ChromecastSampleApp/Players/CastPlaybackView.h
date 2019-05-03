//
//  CastPlaybackView.h
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

@import UIKit;
@class OOVideo;

@interface CastPlaybackView : UIImageView

- (instancetype)init __attribute__((unavailable("init")));
- (instancetype)initWithFrame:(CGRect)frame;// __attribute__((unavailable("initWithFrame:")));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder:")));
- (instancetype)initWithImage:(UIImage *)image __attribute__((unavailable("initWithImage:")));
- (void)configureCastPlaybackViewBasedOnItem:(OOVideo *)item
                                 displayName:(NSString *)displayName
                               displayStatus:(NSString *)displayStatus;
- (void)updateTextView:(OOVideo *)item
           displayName:(NSString *)displayName
         displayStatus:(NSString *)displayStatus;
- (void)playCompleted:(NSString *)displayName
        displayStatus:(NSString *)displayStatus;

@end
