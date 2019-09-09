//
//  IMAAdPodInfo.h
//  GoogleIMA3
//
//  Copyright (c) 2013 Google Inc. All rights reserved.
//
//  Represents podding metadata for a single ad.

#import <Foundation/Foundation.h>

/**
 *  Simple data object containing podding metadata.
 */
@interface IMAAdPodInfo : NSObject

/**
 *  Total number of ads in the pod this ad belongs to. Will be 1 for standalone ads.
 */
@property(nonatomic, readonly) NSInteger totalAds;

/**
 *  The position of this ad within an ad pod. Will be 1 for standalone ads.
 */
@property(nonatomic, readonly) NSInteger adPosition;

/**
 *  Specifies whether the ad is a bumper. Bumpers are short videos used to open
 *  and close ad breaks.
 */
@property(nonatomic, readonly) BOOL isBumper;

/**
 *  Client side: Returns the index of the ad pod. For a preroll pod, returns 0.
 *  For midrolls, returns 1, 2,..., N. For a postroll pod, returns -1. Defaults
 *  to 0 if this ad is not part of a pod, or this pod is not part of a playlist.
 *  DAI live stream: Always returns -1.
 *  DAI VOD: Returns the index of the ad pod. For a preroll pod, returns 0. For
 *  midrolls, returns 1, 2,...,N. For a postroll pod, returns N+1...N+X.
 *  Defaults to 0 if this ad is not part of a pod, or this pod is not part of a
 *  playlist.
 */
@property(nonatomic, readonly) NSInteger podIndex;

/**
 *  The position of the pod in the content in seconds. Pre-roll returns 0,
 *  post-roll returns -1 and mid-rolls return the scheduled time of the pod.
 */
@property(nonatomic, readonly) NSTimeInterval timeOffset;

/**
 *  The maximum duration of the pod in seconds. For unknown duration, -1 is returned.
 */
@property(nonatomic, readonly) NSTimeInterval maxDuration;

/**
 * :nodoc:
 */
- (instancetype)init NS_UNAVAILABLE;

@end
