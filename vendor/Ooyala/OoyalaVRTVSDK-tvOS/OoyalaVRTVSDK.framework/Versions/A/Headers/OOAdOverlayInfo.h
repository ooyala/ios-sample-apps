//
//  OOAdOverlayInfo.h
//  OoyalaSDK
//
//  Created on 5/4/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

@import Foundation;

@class OOVASTNonLinear;

@interface OOAdOverlayInfo : NSObject

@property (readonly, nonatomic) NSInteger width;
@property (readonly, nonatomic) NSInteger height;
@property (readonly, nonatomic) NSInteger expandedWidth;
@property (readonly, nonatomic) NSInteger expandedHeight;
@property (readonly, nonatomic) NSString *resourceUrl;
@property (readonly, nonatomic) NSString *clickUrl;

- (instancetype)initWithWidth:(NSInteger)width
                       height:(NSInteger)height
                expandedWidth:(NSInteger)expandedWidth
               expandedHeight:(NSInteger)expandedHeight
                  resourceUrl:(NSString *)resourceUrl
                     clickUrl:(NSString *)clickUrl;

- (instancetype)initWithNonLinear:(OOVASTNonLinear *)nonLinear;

- (NSDictionary *)dictionaryView;

@end
