//
//  CountdownView.h
//  ReactNativeCountdownTimer
//
//  Created by Eric Vargas on 11/30/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTComponent.h"

@interface CountdownView : UIView

@property (nonatomic, copy) RCTBubblingEventBlock onTimerUpdate;
@property (nonatomic, copy) RCTBubblingEventBlock onTimerCompleted;

@property (nonatomic) float time;
@property (nonatomic) float timeLeft;
@property (nonatomic) CGFloat radius;
@property (strong, nonatomic) UIColor *fillColor;
@property (nonatomic) float fillAlpha;
@property (strong, nonatomic) UIColor *strokeColor;
@property (nonatomic) BOOL automatic;

@end
