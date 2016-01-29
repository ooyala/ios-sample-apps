//
//  OOImagesIOS7.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OOImagesIOS7 : NSObject

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

+ (UIImage *) castOffImage;
+ (UIImage *) castOnImage;
+ (UIImage *) castOn0Image;
+ (UIImage *) castOn1Image;
+ (UIImage *) castOn2Image;
+ (UIImage *) volumeImage;
@end
