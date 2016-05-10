/**
 * @class      OOMoviePlayer OOMoviePlayer.h "OOMoviePlayer.h"
 * @brief      OOMoviePlayer
 * @details    OOMoviePlayer.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "OOPlayer.h"

@interface OOMoviePlayer : OOPlayer {
  BOOL isAudioOnlyStreamPlaying;
}

@property (readonly) OOSeekStyle seekStyle;
@property (readonly, nonatomic, strong) OOOoyalaError *playerError;
@property(readonly, nonatomic, assign) BOOL isAudioOnlyStreamPlaying;
@property(nonatomic, strong) OOStreamPlayer *basePlayer;
@property(nonatomic) NSString *authToken;
- (void) removeObservers;
- (BOOL)setup:(NSArray *)streams parent:(OOOoyalaPlayer*)parent authToken:(NSString*)authToken;
- (void)suspend;
- (void)resume;
- (BOOL) hasCustomControls;
@end
