//
//Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOStreamPlayer.h"

@protocol OOStreamPlayerMappingPredicate;
@protocol OOStreamPlayerMappingCreator;

@interface OOStreamPlayerMapping : NSObject
-(void) addPredicate:(id<OOStreamPlayerMappingPredicate>)predicate creator:(id<OOStreamPlayerMappingCreator>)creator;
-(OOStreamPlayer *)getCorrectPlayerForStreams:(NSArray *)streams;
@end