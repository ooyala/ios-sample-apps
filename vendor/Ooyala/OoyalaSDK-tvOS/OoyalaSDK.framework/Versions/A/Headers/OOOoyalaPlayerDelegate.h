//
//  OOOoyalaPlayerDelegate.h
//  OoyalaSDK
//
//  Created on 11/30/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#ifndef OOOoyalaPlayerDelegate_h
#define OOOoyalaPlayerDelegate_h

@import Foundation;

#import "OOPlayerState.h"

@protocol OOOoyalaPlayerDelegate <NSObject>

- (void)ooyalaPlayerDidChangeToState:(OOOoyalaPlayerState)state;
- (void)ooyalaPlayerDidSwitchToPlayBack;
- (void)ooyalaPlayerDidSwitchToAd;

@end

#endif /* OOOoyalaPlayerDelegate_h */
