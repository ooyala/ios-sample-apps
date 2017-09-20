/**
 * @class      OOStream OOStream.h "OOStream.h"
 * @brief      OOStream
 * @details    OOStream.h in OoyalaSDK
 * @date       11/24/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOTBXML.h"
#import "OOReturnState.h"

@class OOStream;

/**
 * The block used to select the correct OOStream to play.
 * @param[in] streams the array of streams to select from
 * @returns the OOStream to play
 */
typedef OOStream *(^OOStreamSelector)(NSArray *streams);

@interface OOStream : NSObject {
  NSString *deliveryType;
  NSString *videoCodec;
  NSString *urlFormat;
  NSString *framerate;
  NSInteger videoBitrate;
  NSInteger audioBitrate;
  NSInteger height;
  NSInteger width;
  NSString *url;
  NSString *aspectRatio;
  BOOL isLiveStream;
}

@property(readonly, nonatomic, strong) NSString *deliveryType; /**< The OOStream's delivery type */
@property(readonly, nonatomic, strong) NSString *videoCodec; /**< The OOStream's video codec */
@property(readonly, nonatomic, strong) NSString *urlFormat; /**< The OOStream's url format */
@property(readonly, nonatomic, strong) NSString *framerate; /**< The OOStream's framerate */
@property(readonly, nonatomic) NSInteger videoBitrate; /**< The OOStream's video bitrate */
@property(readonly, nonatomic) NSInteger audioBitrate; /**< The OOStream's audio bitrate */
@property(readonly, nonatomic) NSInteger height; /**< The OOStream's height */
@property(readonly, nonatomic) NSInteger width; /**< The OOStream's width */
@property(readonly, nonatomic, strong) NSString *url; /**< The OOStream's URL in the format specified by OOStream.urlFormat */
@property(readonly, nonatomic, strong) NSString *aspectRatio; /**< The OOStream's URL (Remote Asset only) */
@property(readonly, nonatomic, assign) BOOL isLiveStream; /**< The OOStream's URL (Remote Asset only) */
@property(readonly, nonatomic, strong) NSString *profile; /**< The OOStream's encoding profile */

@property (readonly, nonatomic) NSString *drmType;        /**< If drm protected, The OOStream's drm type */
@property (readonly, nonatomic) NSString *licenseUrl;     /**< If drm protected, The OOStream's license url */
@property (readonly, nonatomic) NSString *certificateUrl; /**< If drm protected, The OOStream's certificate url */

/**
 * Get the combined (video+audio) bitrate of this OOStream
 * @returns an NSNumber containing the combined bitrate
 */
- (NSInteger)combinedBitrate;

/**
 * Create a stream for the given URL.
 * @param[in] theUrl an NSURL pointing to an asset for streaming.
 * @param[in] theType see OOConstants.h e.g. OO_DELIVERY_TYPE_HLS.
 */
- (id)initWithUrl:(NSURL *)theUrl deliveryType:(NSString *)theType;

/** @internal
 * Initialize a OOStream using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOStream
 * @returns the initialized OOStream
 */
- (id)initWithDictionary:(NSDictionary *)data;

/** @internal
 * Update the OOStream using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OOStream
 * @returns OOReturnState.OOReturnStateFail if the parsing failed, OOReturnState.OOReturnStateMatched if it was successful
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/** @internal
 * Get an NSURL from the url + urlFormat
 * @returns an NSURL object created by decoding the url according to urlFromat
 */
- (NSURL *)decodedURL;

/** @internal
 * Check if the OOStream is better than the other
 * @returns YES if it is, NO if not
 */
+ (BOOL)is:(OOStream *)stream betterThan:(OOStream *)better;

/** @internal
 * Check if the OOStream is playable
 * @returns YES if it is, NO if not
 */
+ (BOOL)isPlayable:(OOStream *)stream;

/** @internal
 * Check if the OOStream's size, bitrate, and profile are playable
 * @returns YES if the size, bitrate, and profile are playable, NO if not
 */
+ (BOOL)areSizeBitrateAndProfilePlayable:(OOStream *)stream;

/** @internal
 * Check if the OOStream's delivery type is playable
 * @returns YES if the delivery type is playable, NO if not
 */
+ (BOOL)isDeliveryTypePlayable:(OOStream *)stream;

/** @internal
 * Create a OOStream from the given data
 * @param[in] data the data to create the OOStream with
 * @returns the created OOStream
 */
+ (OOStream *)streamFromDictionary:(NSDictionary *)data;

+ (OOStream *)streamFromUrl:(NSURL *)url withType:(NSString *)type;

/** @internal
 * Fetch the best OOStream to play from the given array of streams
 * @param[in] streams the array of streams to select from
 * @returns The hls stream if it exists, otherwise the lowest bitrate mp4 stream
 */
+ (OOStream *)bestStreamFromArray:(NSArray *)streams;

+ (BOOL)containsDeliveryType:(NSString *)type inArray:(NSArray *)streams;

+ (OOStream *)streamWithType:(NSString *)type fromArray:(NSArray *)streams;

/**
 * Set the OOStreamSelector used to select the best stream from an array
 * @param[in] selector the OOStreamSelector to use
 */
+ (void)setStreamSelector:(OOStreamSelector)selector;

/**
 * Reset the OOStreamSelector to the default
 */
+ (void)resetStreamSelector;

@end
