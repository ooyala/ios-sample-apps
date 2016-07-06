//
//Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOOoyalaPlayer;
@class OOStreamPlayer;

@protocol OOStreamPlayerMappingCreator <NSObject>
- (OOStreamPlayer *)newPlayer;
@end