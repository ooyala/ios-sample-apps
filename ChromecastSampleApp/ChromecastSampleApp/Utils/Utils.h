//
//  Utils.h
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@interface Utils : NSObject
/**
 * Get image data from the given url
 * @param[in] imgURL the url where to fetch image
 * @returns NSData initiated with the image fetched from the given url
 */
+ (NSData *)getDataFromImageURL:(NSString *)imgURL;

@end
