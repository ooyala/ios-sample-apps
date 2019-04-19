//
//  NetworkManager.h
//  DiscoverySampleApp
//
//  Created on 4/17/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#ifndef NetworkManager_h
#define NetworkManager_h

@import Foundation;

@interface NetworkManager: NSObject

- (void)getMiddlewareDataForEmbedCode:(NSString *)embedCode
                    andCarouselConfig:(NSDictionary *)carouselConfig
                       withCompletion:(void (^)(NSArray *assets))callback;

@end

#endif /* NetworkManager_h */
