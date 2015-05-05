//
//  OOAdsLearnMoreButton.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOAdMoviePlayer.h"

@interface OOAdsLearnMoreButton : UIView<UIWebViewDelegate>

-(id)initWithAdPlayer:(OOAdMoviePlayer*) AdsPlayer;

-(void)deleteButton;
@end
