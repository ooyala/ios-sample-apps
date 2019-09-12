//
//  OO360GVRRenderHeadPosController.h
//  OoyalaVRSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@class OO360GVRRender;

@interface OO360GVRRenderHeadPosController : NSObject

- (instancetype)initWithRender:(OO360GVRRender *)render;

// A boolean that enables and disabled the pan gesture recognizer.
@property (nonatomic) BOOL enabled;

/**
 A method that adds the pan gesture recognizer to the specified view.
 
 - parameter view: An optional UIView argument. This is the view that the pan gesture recognizer will be added to. If you intend to leverage pan as navigation you must specify this view upfront.
 */
- (void)setupPanGestureRecognizerWithView:(UIView *)view;

@end
