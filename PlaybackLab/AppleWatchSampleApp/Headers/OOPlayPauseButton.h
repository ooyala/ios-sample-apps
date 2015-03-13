//
//  OOPlayPauseButton.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OOPlayPauseButton : UIBarButtonItem

@property (nonatomic) BOOL isPlayShowing;

- (id) initWithScale:(CGFloat)scale;

@end
