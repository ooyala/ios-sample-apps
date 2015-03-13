//
//  OOVideoGravityButton.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OOVideoGravityButton : UIBarButtonItem

- (id) initWithScale:(CGFloat)scale;

- (void)setIsGravityFillShowing:(BOOL)isGravityFillShowing;
@end
