/** 
 * @class      OOOoyalaPlayerView OOOoyalaPlayerView.h "OOOoyalaPlayerView.h"
 * @brief      OOOoyalaPlayerView
 * @details    OOOoyalaPlayerView.h in OoyalaSDK
 * @date       11/28/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface OOOoyalaPlayerView : UIView

@property(nonatomic, weak) AVPlayer *player;

- (AVPlayerLayer *)playerLayer;

@end
