//
//  CastModeOptions.h
//  OoyalaSDK
//
//  Created by Michael Len on 6/17/15.
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol OOEmbedTokenGenerator;

@interface OOCastModeOptions : NSObject

@property(nonatomic, readonly) NSString *embedCode;
@property(nonatomic, readonly) Float64 playhead;
@property(nonatomic, readonly) BOOL isPlaying;
@property(nonatomic, readonly) id<OOEmbedTokenGenerator> embedTokenGenerator;
@property(nonatomic, readonly) NSString * ccLanguage;
@property(nonatomic, readonly) NSString * authToken;

- (id)initWithEmbedCode:(NSString *)embedCode
    initialPlayheadTime:(Float64)playhead
              isPlaying:(BOOL)isPlaying
    embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator
             ccLanguage:(NSString *)ccLanguage
              authToken:(NSString *)authToken;
@end

