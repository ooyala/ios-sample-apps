//
//  OOLocaleHelper.h
//  OoyalaSkinSDK
//
//  Created by Zhihui Chen on 7/9/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOLocaleHelper : NSObject

+ (NSString *)preferredLanguageId;

+ (NSString *)localizedString:(NSDictionary *)localizableStrings locale:(NSString *)locale forKey:(NSString *)key;

@end
