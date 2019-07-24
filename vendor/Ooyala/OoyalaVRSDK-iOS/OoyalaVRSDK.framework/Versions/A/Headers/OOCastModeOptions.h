//
//  CastModeOptions.h
//  OoyalaSDK
//
//  Created on 6/17/15.
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import Foundation;

@protocol OOEmbedTokenGenerator;

@interface OOCastModeOptions : NSObject

@property (nonatomic, readonly) NSString *embedCode;
@property (nonatomic, readonly) Float64 playhead;
@property (nonatomic, readonly) BOOL isPlaying;
@property (nonatomic, readonly) id<OOEmbedTokenGenerator> embedTokenGenerator;
@property (nonatomic, readonly) NSString *ccLanguage;
@property (nonatomic, readonly) NSString *authToken;

- (instancetype)initWithEmbedCode:(NSString *)embedCode
              initialPlayheadTime:(Float64)playhead
                        isPlaying:(BOOL)isPlaying
              embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator
                       ccLanguage:(NSString *)ccLanguage
                        authToken:(NSString *)authToken;

@end


@protocol OOCastNotifiable <NSObject>
/**
 Fires when the cast manager has updated device list

 @param deviceList a dictionary with the cast capable devices
 */
- (void)castManagerDidUpdateDeviceList:(NSDictionary *)deviceList;
/**
 Fires when the cast manager is connecting to a specific device
 */
- (void)castManagerIsConnectingToDevice;
/**
 Fires when the cast manager has connected to a specific device

 @param deviceInfo a dictionary with the name, playing status and preview URL
 */
- (void)castManagerDidConnectToDevice:(NSDictionary *)deviceInfo;
/**
 Fires when the cast manager has disconnected from current device
 */
- (void)castManagerDidDisconnectFromCurrentDevice;

@end


@protocol OOCastManageable <NSObject>
/**
 Forces the cast manager to send devices list
 */
- (void)forceCastDeviceUpdate;
/**
 Notifies that the cast manager should connect to specific device

 @param deviceId a device id
 */
- (void)castDeviceSelected:(NSString *)deviceId;
/**
 Notifies that the cast manager should disconnect from current device
 */
- (void)castDisconnectCurrentDevice;

@end
