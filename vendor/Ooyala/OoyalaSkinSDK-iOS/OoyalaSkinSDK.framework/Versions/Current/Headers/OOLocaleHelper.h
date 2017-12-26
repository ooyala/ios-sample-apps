//
//  OOLocaleHelper.h
//  OoyalaSkinSDK
//
//  Created by Zhihui Chen on 7/9/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kLocalizableStrings;
FOUNDATION_EXPORT NSString * const kLocale;

@interface OOLocaleHelper : NSObject

+ (NSString *)preferredLanguageId;

+ (NSString *)localizedStringFromDictionary:(NSDictionary *)config forKey:(NSString *)key;

@end
