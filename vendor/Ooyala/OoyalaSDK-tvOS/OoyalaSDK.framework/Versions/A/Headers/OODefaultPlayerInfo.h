/**
 * @class      OODefaultPlayerInfo OO.h "OODefaultPlayerInfo.h"
 * @brief      OODefaultPlayerInfo
 * @details    OODefaultPlayerInfo.h in OoyalaSDK
 * @date       1/17/12
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOPlayerInfo.h"
/**
 * This is the default implementation of OOPlayerInfo.  OOPlayerInfo is used for providing information for Authorization
 * You can extend this class and override any of the settings in OOPlayerInfo, then call
 * [OOStreamPlayer setDefaultPlayerInfo:customPlayerInfo]; before you setEmbedCode
 */
@interface OODefaultPlayerInfo : NSObject <OOPlayerInfo>
@end
