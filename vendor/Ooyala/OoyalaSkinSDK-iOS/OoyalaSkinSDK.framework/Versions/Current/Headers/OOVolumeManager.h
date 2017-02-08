//
//  OOVolumeManager.h
//  OoyalaSkinSDK
//
//  Created by Eric Vargas on 10/26/15.
//  Copyright © 2015 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const VolumePropertyKey;
FOUNDATION_EXPORT NSString *const VolumeChangeKey;

@interface OOVolumeManager : NSObject

+ (void)addVolumeObserver:(NSObject *)observer;
+ (void)removeVolumeObserver:(NSObject *)observer;

+ (float)getCurrentVolume;

@end
