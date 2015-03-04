//
//  Util.h
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+ (NSString *)signRequestorId:(NSString *)requestorId keystore:(NSString *)keyStoreName pass:(NSString *)keyStorePass;
+ (NSString *)htmlEntityEncode:(NSString *)string;
+ (NSString *)urlEncode:(NSString *)str;
@end
