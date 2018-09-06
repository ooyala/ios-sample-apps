//
//  OOModule.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOModule : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, strong, readonly) NSDictionary *metadata;

- (id)initWithName:(NSString *)name type:(NSString *)type metadata:(NSDictionary *)metadata;

@end
