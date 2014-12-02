//
//  OOBufferView.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 12/27/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOUIProgressSliderIOS7.h"

@interface OOBufferView : UIView
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Use initWithFrame:slider: instead")));
- (instancetype)initWithFrame:(CGRect)frame slider:(OOUIProgressSliderIOS7*)slider;
@end
