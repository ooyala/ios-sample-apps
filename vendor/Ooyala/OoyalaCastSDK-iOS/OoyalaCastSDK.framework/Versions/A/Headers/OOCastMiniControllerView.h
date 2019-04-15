//
//  OOCastMiniControllerView.h
//  OoyalaSDK
//
//  Created on 9/9/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

@import UIKit;

#import "OOCastMiniControllerProtocol.h"

@class OOCastManager;

@protocol OOCastMiniControllerDelegate <NSObject>
/**
 Fires when a mini controller is clicked

 @param miniControllerView an instance of view conformed to OOCastMiniControllerProtocol
 @param embedCode an embedCode of an asset currently playing
 */
- (void)miniControllerDidClickOn:(nullable id<OOCastMiniControllerProtocol>)miniControllerView
                   withEmbedCode:(nonnull NSString *)embedCode;
/**
 Fires when a mini controller is dismissed

 @param miniControllerView An instance of view conformed to OOCastMiniControllerProtocol
 */
- (void)miniControllerDidDismiss:(nullable id<OOCastMiniControllerProtocol>)miniControllerView;

@end


/**
 A basic implementation of a @c OOCastMiniControllerView
 */
@interface OOCastMiniControllerView : UIView <OOCastMiniControllerProtocol>

/**
 @c UITableViewCell used to display mini controller
 */
@property (nonnull, nonatomic) UITableViewCell *cell;

/**
 Designated initializer for @c OOCastMiniControllerView

 @param frame a frame to use for init
 @param castManager an instance of @c OOCastManager to use with
 @param delegate an instance conforming to @c OOCastMiniControllerDelegate
 @return an initialized @c OOCastMiniControllerView
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame
                          castManager:(nonnull OOCastManager *)castManager
                             delegate:(nullable id<OOCastMiniControllerDelegate>)delegate;

@end
