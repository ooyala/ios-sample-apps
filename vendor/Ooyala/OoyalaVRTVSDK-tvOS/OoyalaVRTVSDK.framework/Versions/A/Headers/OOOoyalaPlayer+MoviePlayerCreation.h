//
//  OOOoyalaPlayer+MoviePlayerCreation.h
//  OoyalaSDK
//
//  Created on 11/1/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

#ifndef OOOoyalaPlayer_MoviePlayerCreation_h
#define OOOoyalaPlayer_MoviePlayerCreation_h

@class OOMoviePlayer;
@class OOVideo;

@interface OOOoyalaPlayer (MoviePlayerCreation)

- (OOMoviePlayer *)getCorrectMoviePlayer:(OOVideo *)video;

@end

#endif /* OOOoyalaPlayer_MoviePlayerCreation_h */
