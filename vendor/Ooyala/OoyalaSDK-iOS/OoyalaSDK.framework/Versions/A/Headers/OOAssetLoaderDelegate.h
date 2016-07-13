//
//  OOAssetLoaderDelegate.h
//  OoyalaSDK
//
//  Created by Zhihui Chen on 1/25/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <AVFoundation/AVAssetResourceLoader.h>
#import "OOSecureURLGenerator.h"

@interface OOAssetLoaderDelegate : NSObject<AVAssetResourceLoaderDelegate>
-(instancetype) init __attribute__((unavailable("init not available")));
-(instancetype) initWithPcode:(NSString*)pcode
                    authToken:(NSString*)authToken
           secureURLGenerator:(id<OOSecureURLGenerator>)secureURLGenerator
                      timeout:(NSTimeInterval)timeout;
@end
