//
//  OOPlayerInfo.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * OOPlayerInfo represents information describing the capabilities of the playback device.
 * These are used e.g. when negotiating with servers so they can choose the most appropriate
 * asset encodings.
 */
@protocol OOPlayerInfo <NSObject>

/*
 A string representing the playback device.
 ALWAYS SET THIS TO @"iphone-html5" until we release sas.ooyala.com
 */
@property (nonatomic, readonly, strong) NSString *device;

/*
 An NSArray of NSStrings describing supported content types for playback
 HDS = @"hds"
 RTMP = @"RTMP"
 HLSs = @"m3u8"
 MP4s = @"mp4"
 AKAMAI HD = @"akamai_hd"
 MS Smooth = @"smooth"

 return nil to not include this parameter
 */
@property (nonatomic, readonly, strong) NSArray *supportedFormats;

/*
 Supported h264 profiles
 @"baseline"
 @"main"
 @"high"

 return nil to not support this parameter
 */
@property (nonatomic, readonly, strong) NSArray *supportedProfiles;

// the max supported video width
// set to -1 to ignore
@property (nonatomic, readonly) int maxWidth;

// the max supported video height
// set to -1 to ignore
@property (nonatomic, readonly) int maxHeight;

// the max supported video bitrate
// set to -1 to ignore
@property (nonatomic, readonly) int maxBitrate;

// the user Agent of this particular player
@property (nonatomic, readonly) NSString *userAgent;
@end
