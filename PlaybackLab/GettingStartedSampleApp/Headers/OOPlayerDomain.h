/**
 * @class      OOPlayerDomain OOPlayerDomain.h "OOPlayerDomain.h"
 * @brief      OOPlayerDomain
 * @details    OOPlayerDomain.h in OoyalaSDK
 * @date       05/15/14
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
* Constrained to require http:// or https://.
*/
@interface OOPlayerDomain : NSObject
+ (id) domainWithString:(NSString*)string;
- (id) init __attribute__((unavailable("Use initWithString: instead")));
- (id) initWithString:(NSString*)domainStr;
- (NSString*)asString;
- (NSURL*)asURL;
@end