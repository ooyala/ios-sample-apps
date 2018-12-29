//
//  OOAudioSession.h
//  OoyalaSDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#ifndef OOAudioSession_h
#define OOAudioSession_h

@import Foundation;

@protocol OOAudioSessionDelegate <NSObject>
@optional
- (void)volumeChanged:(float)volume;
@end

@interface OOAudioSession : NSObject

@property (readonly) BOOL isMuted;
@property (nonatomic, readonly) float playerVolume;
@property (nonatomic, readonly) float deviceVolume;
@property (nonatomic, readonly) float applicationVolume;
@property (nonatomic, weak) id<OOAudioSessionDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)prioritize;
- (void)deprioritize;

- (void)removeVolumeObserver:(NSObject *)observer;
- (void)addVolumeObserver:(NSObject *)observer;
- (void)disableSession;
- (void)volumeChanged:(float)systemVolume;

@end

#endif /* OOAudioSession_h */

