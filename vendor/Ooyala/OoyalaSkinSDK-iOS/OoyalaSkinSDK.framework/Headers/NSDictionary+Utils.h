//
//  NSDictionary+Utils.h
//  OoyalaSkinSDK
//
//  Created on 11/6/15.
//  Copyright © 2015 ooyala. All rights reserved.
//

@import Foundation;

@interface NSDictionary (Utils)

+ (NSDictionary *)dictionaryFromSkinConfigFile:(NSString *)filename mergedWith:(NSDictionary *)dict;
+ (NSDictionary *)dictionaryFromJson:(NSString *)filename;

@end
