//
//  OOLocaleHelper.h
//  OoyalaSkinSDK
//
//  Created on 7/9/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

@import Foundation;

FOUNDATION_EXPORT NSString *const kLocalizableStrings;
FOUNDATION_EXPORT NSString *const kLocale;

@interface OOLocaleHelper : NSObject

+ (NSString *)preferredLanguageId;

+ (NSString *)localizedStringFromDictionary:(NSDictionary *)config forKey:(NSString *)key;

@end
