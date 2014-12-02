//
//  OOImagesIOS7.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/22/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOImages.h"

@interface OOImagesIOS7 : OOImages

+ (UIImage *)playImage:(CGSize)size;
+ (UIImage *)pauseImage:(CGSize)size;
+ (UIImage *)maximizeImage:(CGSize)size;
+ (UIImage *)nextImage:(CGSize)size;
+ (UIImage *)previousImage:(CGSize)size;
+ (UIImage *)closedCaptionsImage;
+ (UIImage *)expandImage;
+ (UIImage *)collapseImage;
+ (UIImage *)forwardImage;
+ (UIImage *)rewindImage;
+ (UIImage *)playImage;
+ (UIImage *)pauseImage;
+ (UIImage *)thumbImage;
+ (UIImage *)routeImage;
+ (UIImage *)routeOnImage;
@end
