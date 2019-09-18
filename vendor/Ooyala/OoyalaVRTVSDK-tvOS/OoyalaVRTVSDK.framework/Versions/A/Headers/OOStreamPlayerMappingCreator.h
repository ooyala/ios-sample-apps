//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import Foundation;

@class OOStreamPlayer;

@protocol OOStreamPlayerMappingCreator <NSObject>

- (OOStreamPlayer *)newPlayer;

@end
