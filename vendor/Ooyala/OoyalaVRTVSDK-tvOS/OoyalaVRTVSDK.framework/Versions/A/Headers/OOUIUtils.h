/**
 * @class      OOUIUtils OOUIUtils.h "OOUIUtils.h"
 * @brief      OOUIUtils
 * @details    OOUIUtils.h in OoyalaSDK
 * @date       1/20/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OOUIUtils : NSObject

+(void) doSafeGStateBlock:(void(^)(CGContextRef))block;

+ (UIColor *)colorByDarkening:(UIColor*)color by:(float)factor;

+ (UIImage *)imageFromBase64String: (NSString *)string;

+ (BOOL)isIpad;

+ (BOOL)is1xDensity;

/**
 * If called on the main thread, the block will be invoked immediately.
 * Otherwise it will be dispatched to run on the main thread.
 * @param a block of code to run on the main thread.
 */
+(void) runOnMainThread:(void (^)(void))block;

@end
