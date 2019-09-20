//
//  OOOoyalaPlayer+Cast.h
//  OoyalaSDK
//
//  Created on 10/31/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

#ifndef OOOoyalaPlayer_Cast_h
#define OOOoyalaPlayer_Cast_h

@protocol OOCastManagerProtocol;

@interface OOOoyalaPlayer (Cast)

- (void)initCastManager:(id<OOCastManagerProtocol>)castManager;

- (void)switchToCastMode;

- (void)exitCastModeWithEmbedCode:(NSString *)embedCode
                     playheadTime:(Float64)playheadTime
                        isPlaying:(BOOL)isPlaying;

- (BOOL)isInCastMode;

@end

#endif /* OOOoyalaPlayer_Cast_h */
