//
//  OOCastPlayer.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/29/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleCast/GoogleCast.h>
#import <OoyalaSDK/OOPlayerProtocol.h>
#import <OoyalaSDK/OOStateNotifier.h>
#import "OOCastMiniControllerProtocol.h"

@class OOCastManager;

@interface OOCastPlayer : GCKCastChannel<OOPlayerProtocol>

@property(nonatomic, strong) OOStateNotifier *stateNotifier;

@property(nonatomic, strong) NSString *embedCode;

@property(nonatomic) Float64 playheadTime;

@property(nonatomic, strong) NSString *castItemTitle;

@property(nonatomic, strong) NSString *castItemDescription;

@property(nonatomic, strong) NSString *castItemPromoImg;

@property(nonatomic, weak) OOCastManager *castManager;

- (void)initStateNotifier:(OOStateNotifier *)stateNotifier;

- (void)updateMetadataFromOoyalaPlayer:(NSString *)castItemPromoImg castItemTitle:(NSString *)castItemTitle castItemDescription:(NSString *)castItemDescription seekable:(BOOL)isSeekable;

- (void)enterCastMode:(NSString *)embedCode playheadTime:(Float64)playheadTime isPlaying:(BOOL)isPlaying embedToken:(NSString *)embedToken;

- (void)registerMiniController:(id<OOCastMiniControllerProtocol>) miniController;

- (void)deregisterMiniController:(id<OOCastMiniControllerProtocol>)miniController;

- (void)onExitCastMode;
@end
