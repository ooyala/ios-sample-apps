//
//  OOVASTUtils.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOVASTUtils : NSObject
+(void)setAdvertisingId:(NSString*)adId;
+(NSString*)advertisingId;
+ (NSURL *)urlFromAdUrlString:(NSString *)url;
@end
