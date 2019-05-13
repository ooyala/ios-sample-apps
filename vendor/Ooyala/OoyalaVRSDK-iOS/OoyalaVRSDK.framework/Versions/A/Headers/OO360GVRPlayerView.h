//
//  OO360GVRPlayerView.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayerView.h"

#ifndef OO360GVRPlayerView_h
#define OO360GVRPlayerView_h

/**
 * @class OO360GVRPlayerView
 * @brief An OO360GVRPlayerView using to show VR scene
 */
@interface OO360GVRPlayerView : OOOoyalaPlayerView

/**
 * @enum OO360VideoType
 * @discussion Enum with video rendering possible types
 */
typedef NS_ENUM(NSInteger, OO360VideoType) {
  /** Render video in mono type with handle touches */
  Mono,
  /** Render video in stereo type for using cardboard without handling touches */
  Stereo,
};
/**
 * @property videoType
 * @brief This property is using to choose scene for a rendering. Default: Mono
 */
@property (nonatomic, assign) OO360VideoType videoType;

/**
 *  @brief Switch video mode between Stereo and Mono
 *  @param type New video type, that will be choose a scene to render
 */
- (void)switchVideoType:(OO360VideoType)type;

/**
 *  @brief Pause render when video has been paused
 *  @see 00360GVRRenderView
 *  @param paused true if video has been paused, false otherwise
 */
- (void)setPaused:(BOOL)paused;

/**
 *  @abstract Hide render view if video has ended
 *  @see 00360GVRRenderView
 *  @param hidden: true if needs to hide render view, false otherwise
 */
- (void)setHidden:(BOOL)hidden;

@end

#endif /* OO360GVRPlayerView_h */
