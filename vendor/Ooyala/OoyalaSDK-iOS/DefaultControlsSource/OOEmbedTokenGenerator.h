//
//  OOEmbedTokenGenerator.h
//  OoyalaSDK
//
//  Created by Chris Leonavicius on 4/16/12.
//  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OOEmbedTokenCallback)(NSString *);

@protocol OOEmbedTokenGenerator <NSObject>
  - (void)tokenForEmbedCodes:(NSArray *)embedCodes callback:(OOEmbedTokenCallback)callback;
@end
