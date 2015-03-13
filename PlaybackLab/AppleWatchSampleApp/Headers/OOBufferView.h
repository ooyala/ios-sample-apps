//
//  OOBufferView.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOUIProgressSliderIOS7.h"

@interface OOBufferView : UIView
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Use initWithFrame:slider: instead")));
- (instancetype)initWithFrame:(CGRect)frame slider:(OOUIProgressSliderIOS7*)slider;
@end
