/**
 * @class      OOUIUtils OOUIUtils.h "OOUIUtils.h"
 * @brief      OOUIUtils
 * @details    OOUIUtils.h in OoyalaSDK
 * @date       1/20/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface OOUIUtils : NSObject

+(void) doSafeGStateBlock:(void(^)(CGContextRef))block;

+ (UIColor *)colorByDarkening:(UIColor*)color by:(float)factor;

+ (UIImage *)imageFromBase64String: (NSString *)string;

+ (BOOL)isIpad;

+ (BOOL)is1xDensity;

@end
