//
//  Marker.h
//  OoyalaSDK
//
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

@import Foundation;

/**
 Stores the info for a marker.
 */
@interface OOMarker : NSObject

@property (readonly, nonatomic) NSString *type;
@property (readonly, nonatomic) Float64 start;
@property (readonly, nonatomic) Float64 end;
@property (readonly, nonatomic) NSString *markerColor;
@property (readonly, nonatomic) NSString *backgroundColor;
@property (readonly, nonatomic) NSString *hoverColor;
@property (readonly, nonatomic) NSString *iconUrl;
@property (readonly, nonatomic) NSString *imageUrl;
@property (readonly, nonatomic) NSString *text;

- (instancetype)init __attribute__((unavailable("use initWithDictionary:")));

/**
 Initializes a @c OOMarker using @c NSDictionary.
 */
- (instancetype)initWithDictionary:(NSDictionary *)data;

/**
 Initializes and returns @c OOMarker using @c NSDictionary.
 */
+ (instancetype)initWithDictionary:(NSDictionary *)data;

/**
 Updates @c OOMarker using a @c NSDictionary.
 */
- (void)updateWithDictionary:(NSDictionary *)data;

/**
 Gets a @c NSString with the json representation of the @c OOMarker.
 */
- (NSString *)toJsonString;

@end

