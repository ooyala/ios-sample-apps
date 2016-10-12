//
//  OOEmbedTokenGenerator.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OOEmbedTokenCallback)(NSString *);

@protocol OOEmbedTokenGenerator <NSObject>
  - (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback;
@end
