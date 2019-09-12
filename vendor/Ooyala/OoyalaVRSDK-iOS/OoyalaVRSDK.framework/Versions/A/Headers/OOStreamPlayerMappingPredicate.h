//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import Foundation;

@protocol OOStreamPlayerMappingPredicate <NSCopying>

- (BOOL)matchesStreams:(NSArray *)streams;

@end
