/**
 * @class      OOImages OOImages.h "OOImages.h"
 * @brief      OOImages
 * @details    OOImages.h in OoyalaSDK
 * @date       1/12/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface OOImages : NSObject

+ (UIImage *)playImage:(CGSize)size;
+ (UIImage *)pauseImage:(CGSize)size;
+ (UIImage *)maximizeImage:(CGSize)size;
+ (UIImage *)nextImage:(CGSize)size;
+ (UIImage *)previousImage:(CGSize)size;
+ (UIImage *)closedCaptionsImage;

@end
