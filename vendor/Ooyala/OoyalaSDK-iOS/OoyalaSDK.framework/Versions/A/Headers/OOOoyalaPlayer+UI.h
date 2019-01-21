//
//  OOOoyalaPlayer+UI.h
//  OoyalaSDK
//
//  Created on 10/31/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

#ifndef OOOoyalaPlayer_UI_h
#define OOOoyalaPlayer_UI_h

@interface OOOoyalaPlayer (UI)

- (void)showPromoImage;
- (void)hidePromoImage;

/**
 * @returns the video rect
 */
- (CGRect)videoRect;

/**
 * internal Ooyala use only.
 */
- (void)layoutSubviews;

@end

#endif /* OOOoyalaPlayer_UI_h */
