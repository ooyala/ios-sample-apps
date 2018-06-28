//
//  FullscreenStateOperation.h
//  OoyalaSkinSDK
//
//  Copyright © 2018 ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FullscreenStateOperation : NSOperation

- (instancetype)initWithFullscreen:(BOOL)isFullscreen
              enterFullscreenBlock:(void (^)(void (^animationCompletion)()))fullscreenBlock
                  enterInlineBlock:(void (^)(void (^animationCompletion)()))inlineBlock
           andCompleteStateChanges:(void (^)())completeStateChanges;

@end
