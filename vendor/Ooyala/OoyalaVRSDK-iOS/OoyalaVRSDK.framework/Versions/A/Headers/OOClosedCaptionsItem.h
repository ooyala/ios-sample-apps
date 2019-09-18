/**
 * @class      OOClosedCaptionsItem OOClosedCaptionsItem.h "OOClosedCaptionsItem.h"
 * @brief      OOClosedCaptionsItem
 * @details    OOClosedCaptionsItem.h in OoyalaSDK
 * @date       09/02/15
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

@class OOContentTreeVttCaption;

@interface OOClosedCaptionsItem : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *url;

- (instancetype)init __attribute__((unavailable("use initWithDictionary")));
- (instancetype)initWithContentTreeVttCaption:(OOContentTreeVttCaption *)vttCaption;

@end
