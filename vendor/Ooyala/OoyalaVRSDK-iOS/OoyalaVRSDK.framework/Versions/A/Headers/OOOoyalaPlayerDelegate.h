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
#import "OOPlayerProtocol.h"

@protocol OOOoyalaPlayerDelegate <NSObject>

- (void)ooyalaPlayerDidChangeToState:(OOOoyalaPlayerState)state;

@end


#endif /* OOOoyalaPlayerDelegate_h */
