//
//  FullscreenStateOperation.h
//  OoyalaSkinSDK
//
//  Copyright © 2018 ooyala. All rights reserved.
//

@import Foundation;

@interface FullscreenStateOperation : NSOperation

- (instancetype)initWithFullscreen:(BOOL)isFullscreen
              enterFullscreenBlock:(void (^)(void (^animationCompletion)(void)))fullscreenBlock
                  enterInlineBlock:(void (^)(void (^animationCompletion)(void)))inlineBlock
           andCompleteStateChanges:(void (^)(void))completeStateChanges;

@end
