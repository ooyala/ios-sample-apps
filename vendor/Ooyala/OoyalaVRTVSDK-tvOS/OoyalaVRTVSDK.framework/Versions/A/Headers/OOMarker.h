//
//  Marker.h
//  OoyalaSDK
//
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

@import Foundation;

@class OOSASMarker;

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

- (instancetype)init __attribute__((unavailable("use initWithSASMarker:")));

/**
 Initializes a @c OOMarker using @c OOSASMarker.
 */
- (instancetype)initWithSASMarker:(OOSASMarker *)sasMarker;

/**
 Initializes and returns @c OOMarker using @c OOSASMarker.
 */
+ (instancetype)markerFromSASMarker:(OOSASMarker *)sasMarker;

+ (NSArray<OOMarker *> *)arrayFromSASMarkersArray:(NSArray<OOSASMarker *> *)sasMarkersArray;

/**
 Gets a @c NSString with the json representation of the @c OOMarker.
 */
- (NSString *)toJsonString;

@end

