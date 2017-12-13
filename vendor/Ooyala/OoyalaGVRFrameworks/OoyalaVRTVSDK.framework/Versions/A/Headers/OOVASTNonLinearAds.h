//
//  OOVASTNonLinearAds.h
//  OoyalaSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOTBXML.h"

/**
 * A list of non-linear, static advertisement that was defined in a VAST XML
 * \ingroup vast
 */
@interface OOVASTNonLinearAds : NSObject

@property (readonly, nonatomic, strong) NSMutableDictionary *trackingEvents;
@property (readonly, nonatomic, strong) NSMutableArray *nonLinears;

- (id)initWithElement:(OOTBXMLElement *)element;

@end
