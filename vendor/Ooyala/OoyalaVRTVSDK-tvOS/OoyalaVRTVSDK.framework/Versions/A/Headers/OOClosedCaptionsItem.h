/**
 * @class      OOClosedCaptionsItem OOClosedCaptionsItem.h "OOClosedCaptionsItem.h"
 * @brief      OOClosedCaptionsItem
 * @details    OOClosedCaptionsItem.h in OoyalaSDK
 * @date       09/02/15
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */
#import <Foundation/Foundation.h>

@interface OOClosedCaptionsItem : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *url;

- (instancetype)init __attribute__((unavailable("use initWithDictionary")));
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
