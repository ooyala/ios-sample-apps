//
//  Utils.m
//  ChromecastSampleApp
//
//  Created by Liusha Huang on 9/18/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import "Utils.h"

@implementation Utils


+ (NSData *)getDataFromImageURL:(NSString *)imgURL{
  if (imgURL == nil) {
    return nil;
  }
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *cacheFileName = [self sha1HashForString:imgURL];
  NSURL *cacheDirectory = [[[fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"thumbnails"];
  NSURL *cacheFileURL = [cacheDirectory URLByAppendingPathComponent:cacheFileName];

  if ([fileManager fileExistsAtPath:[cacheFileURL path]]) {
      //Cache hit
    NSLog(@"cache log hit file to URL = %@", cacheFileURL);
    return [[NSData alloc] initWithContentsOfURL:cacheFileURL];
  } else {
      // Retrive the data from the internet
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:imgURL]];
      // Create the cache directorty, if needed
    NSError *error;
    if (![fileManager fileExistsAtPath:[cacheDirectory path]]) {
      [fileManager createDirectoryAtURL:cacheDirectory withIntermediateDirectories:YES attributes:nil error:&error];

      if (error) {
        NSLog(@"Received an error while trying to create a directory %@", [error localizedDescription]);
      }
    }

    error = nil;
      // Write the image to our cache
    NSLog(@"cache log writing file to URL = %@", cacheFileURL);
    [imageData writeToURL:cacheFileURL options:NSDataWritingAtomic error:&error];
    if (error) {
      NSLog(@"Received an error while trying to save a cached file %@", [error localizedDescription]);
    }
    return imageData;
  }
}

+ (NSString *)sha1HashForString: (NSString *) input {
  NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];

  uint8_t digest[CC_SHA1_DIGEST_LENGTH];

  CC_SHA1([data bytes], [data length], digest);

  NSMutableString *hash = [NSMutableString stringWithCapacity:40];
  for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    [hash appendFormat:@"%02x", digest[i]];

  return hash;
}

+ (void)cleanupLocalFiles {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSURL *cacheDirectory = [[[fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"thumbnails"];

  NSError *error;
  NSArray *cacheFiles = [fileManager contentsOfDirectoryAtPath:[cacheDirectory path] error:&error];
  for (NSString *file in cacheFiles) {
    error = nil;
    NSLog(@"cache log deleting file in URL = %@", [[cacheDirectory path] stringByAppendingPathComponent:file]);
    [fileManager removeItemAtPath:[[cacheDirectory path] stringByAppendingPathComponent:file] error:&error];
    /* handle error */
  }
}


+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
  CGSize scaledSize = newSize;
  float scaleFactor = 1.0;
  if (image.size.width > image.size.height) {
    scaleFactor = image.size.width / image.size.height;
    scaledSize.width = newSize.width;
    scaledSize.height = newSize.height / scaleFactor;
  } else {
    scaleFactor = image.size.height / image.size.width;
    scaledSize.height = newSize.height;
    scaledSize.width = newSize.width / scaleFactor;
  }

  UIGraphicsBeginImageContextWithOptions(scaledSize, NO, 0.0);
  CGRect scaledImageRect = CGRectMake(0.0, 0.0, scaledSize.width, scaledSize.height);
  [image drawInRect:scaledImageRect];
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return scaledImage;
}

+ (UIViewController*) currentTopUIViewController {
  UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

  while (topController.presentedViewController) {
    topController = topController.presentedViewController;
  }
  return topController;
}

@end
