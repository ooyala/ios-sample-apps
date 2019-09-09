//
//  OOPlayPauseButton.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "OOScalableImageButton.h"

#ifndef OOPlayPauseButton_h
#define OOPlayPauseButton_h

/** @internal
 Possible icons for @c OOPlayPauseButton
 */
typedef NS_ENUM(NSInteger, OOButtonIcon) {
  OOButtonIconPlay,
  OOButtonIconPause,
  OOButtonIconReplay
};

@interface OOPlayPauseButton : OOScalableImageButton

@property (nonatomic) OOButtonIcon buttonIcon;

@end

#endif /* OOPlayPauseButton_h */
