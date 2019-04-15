//
//  OOPlayPauseButton.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "OOScalableImageButton.h"

#ifndef OOPlayPauseButton_h
#define OOPlayPauseButton_h

@interface OOPlayPauseButton : OOScalableImageButton

@property (nonatomic) BOOL isPlayShowing; /**< set to YES to show the play icon, or NO to show the pause icon */

- (void)showReplayIcon; /**< called when playback is completed */

@end

#endif /* OOPlayPauseButton_h */
