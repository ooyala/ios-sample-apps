//
//Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OOStreamPlayerMappingPredicate <NSCopying>
-(BOOL) matchesStreams:(NSArray*)streams;
@end