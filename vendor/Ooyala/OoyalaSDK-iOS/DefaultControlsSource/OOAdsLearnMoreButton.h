//
//  OOAdsLearnMoreButton.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 7/21/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOAdMoviePlayer.h"

@interface OOAdsLearnMoreButton : UIView<UIWebViewDelegate>

-(id)initWithAdPlayer:(OOAdMoviePlayer*) AdsPlayer;

-(void)deleteButton;
@end
