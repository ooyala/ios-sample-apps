//
//  OOAdPricing.h
//  Pulse
//
//  Created by Joao Sampaio on 10/02/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Used to provide a value that represents a price that can be used by real-time bidding (RTB) systems. VAST is not designed to handle RTB since other methods exist, but this element is offered for custom solutions if needed.
 */
@interface OOAdPricing : NSObject

/**
 The price's value that can be used by real-time bidding (RTB).
 */
- (NSNumber *)pricing;

/**
 The pricing model of the ad. It can be one of: CPM, CPC, CPE or CPV.
 */
- (NSString *)model;

/**
 The currency of the ad's price, containing a three-letter ISO-4217 currency symbol.
 */
- (NSString *)currency;

@end
