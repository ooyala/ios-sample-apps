//
//  CountdownView.h
//  ReactNativeCountdownTimer
//
//  Created on 11/30/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

@import UIKit;
#import <React/RCTComponent.h>

@interface CountdownView : UIView

@property (nonatomic, copy) RCTBubblingEventBlock onTimerUpdate;
@property (nonatomic, copy) RCTBubblingEventBlock onTimerCompleted;

@property (nonatomic) float time;
@property (nonatomic) float timeLeft;
@property (nonatomic) CGFloat radius;
@property (nonatomic) UIColor *fillColor;
@property (nonatomic) float fillAlpha;
@property (nonatomic) UIColor *strokeColor;
@property (nonatomic) BOOL automatic;

@end
