//
//  Utils.h
//  ChromecastSampleApp
//
//  Created by Liusha Huang on 9/18/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonHMAC.h>

@interface Utils : NSObject
/**
 * Get image data from the given url
 * @param[in] imgURL the url where to fetch image
 * @returns NSData initiated with the image fetched from the given url
 */
+ (NSData *)getDataFromImageURL:(NSString *)imgURL;

/**
 * Clean up thumbnail saved in the cache
 */
+ (void)cleanupLocalFiles;

/**
 * Hash input string
 * @param[in] input the NSString to be hashed
 * @returns hased NSString
 */
+ (NSString *)sha1HashForString: (NSString *) input;

/**
 * Scale image to the given size
 * @param[in] image the image to be scaled
 * @param[in] newSize the size the given image will be scaled to
 * @returns scaled UIImage
 */
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

+ (UIViewController*) currentTopUIViewController;
@end
