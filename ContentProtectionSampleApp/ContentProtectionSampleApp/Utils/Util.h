//
//  Util.h
//  AdobePassDemoApp
//
//  Created on 5/16/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (NSString *)signRequestorId:(NSString *)requestorId
                     keystore:(NSString *)keyStoreName
                         pass:(NSString *)keyStorePass;
+ (NSString *)htmlEntityEncode:(NSString *)string;
+ (NSString *)urlEncode:(NSString *)str;

@end
