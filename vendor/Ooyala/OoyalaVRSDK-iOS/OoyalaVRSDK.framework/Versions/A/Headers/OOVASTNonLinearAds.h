//
//  OOVASTNonLinearAds.h
//  OoyalaSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import "OOTBXML.h"

/**
 * A list of non-linear, static advertisement that was defined in a VAST XML
 * \ingroup vast
 */
@interface OOVASTNonLinearAds : NSObject

@property (readonly, nonatomic) NSMutableDictionary *trackingEvents;
@property (readonly, nonatomic) NSMutableArray *nonLinears;

- (instancetype)initWithElement:(OOTBXMLElement *)element;

@end
