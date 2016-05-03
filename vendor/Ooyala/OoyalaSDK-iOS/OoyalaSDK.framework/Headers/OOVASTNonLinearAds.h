//
//  OOVASTNonLinearAds.h
//  OoyalaSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOTBXML.h"

@interface OOVASTNonLinearAds : NSObject

@property (readonly, nonatomic, strong) NSMutableDictionary *trackingEvents;
@property (readonly, nonatomic, strong) NSMutableArray *nonLinears;

- (id)initWithElement:(OOTBXMLElement *)element;

@end
