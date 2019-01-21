//
//  OOCastMiniControllerView.h
//  OoyalaSDK
//
//  Created on 9/9/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOCastMiniControllerProtocol.h"

@class OOCastManager;

@protocol OOCastMiniControllerDelegate <NSObject>

/**
 Fires when a mini controller is clicked

 @param miniControllerView An instance of view conformed to OOCastMiniControllerProtocol
 */
- (void)miniControllerDidClickOn:(nullable id<OOCastMiniControllerProtocol>)miniControllerView
                   withEmbedCode:(nonnull NSString *)embedCode;
/**
 Fires when a mini controleer is dismissed

 @param miniControllerView An instance of view conformed to OOCastMiniControllerProtocol
 */
- (void)miniControllerDidDismiss:(nullable id<OOCastMiniControllerProtocol>)miniControllerView;

@end


@interface OOCastMiniControllerView : UIView <OOCastMiniControllerProtocol>

@property (nonnull, nonatomic) UITableViewCell *cell;

- (nonnull instancetype)initWithFrame:(CGRect)frame
                          castManager:(nullable OOCastManager *)castManager
                             delegate:(nullable id<OOCastMiniControllerDelegate>)delegate;

@end
