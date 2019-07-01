//
//  OOModule.h
//  OoyalaSDK
//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import Foundation;

@interface OOModule : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSDictionary *metadata;

- (instancetype)initWithName:(NSString *)name
                        type:(NSString *)type
                    metadata:(NSDictionary *)metadata;

@end
