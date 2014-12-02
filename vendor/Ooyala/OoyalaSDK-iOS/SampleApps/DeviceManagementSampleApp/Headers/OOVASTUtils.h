//
//  OOVASTUtils.h
//  OoyalaSDK
//
//  Created by Jon Slenk on 5/28/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOVASTUtils : NSObject
+(void)setAdvertisingId:(NSString*)adId;
+(NSString*)advertisingId;
+ (NSURL *)urlFromAdUrlString:(NSString *)url;
@end
