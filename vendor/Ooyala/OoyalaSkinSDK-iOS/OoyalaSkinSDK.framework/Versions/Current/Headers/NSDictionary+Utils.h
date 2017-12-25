//
//  NSDictionary+Utils.h
//  OoyalaSkinSDK
//
//  Created by Eric Vargas on 11/6/15.
//  Copyright © 2015 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Utils)

+ (NSDictionary *) dictionaryFromSkinConfigFile:(NSString *)filename mergedWith:(NSDictionary *)dict;
+ (NSDictionary *)dictionaryFromJson:(NSString *)filename;

@end
