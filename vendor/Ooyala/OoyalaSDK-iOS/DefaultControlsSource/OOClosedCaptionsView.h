/**
 * @class      OOClosedCaptionsView OOClosedCaptionsView.h "OOClosedCaptionsView.h"
 * @brief      OOClosedCaptionsView
 * @details    OOClosedCaptionsView.h in OoyalaSDK
 * @date       1/6/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class OOCaption;
@class OOClosedCaptionsStyle;

@interface OOClosedCaptionsView : UIView {
  OOCaption *caption;
  OOClosedCaptionsStyle *style;
}

@property (nonatomic, strong) OOCaption *caption;

@property (nonatomic, strong) OOClosedCaptionsStyle *style;
@end
