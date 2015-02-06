/**
 * @class      OOCaption OOCaption+Internal.h "OOCaption+Internal.h"
 * @brief      OOCaption
 * @details    OOCaption+Internal.h in OoyalaSDK
 * @date       12/12/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOCaption.h"

@interface OOCaption(Internal)

/**
 * INTERNAL
 * @internal
 * append a caption to an existing caption
 * @param[in] the caption to append
 */
- (void)append:(OOCaption *)caption;

@end
