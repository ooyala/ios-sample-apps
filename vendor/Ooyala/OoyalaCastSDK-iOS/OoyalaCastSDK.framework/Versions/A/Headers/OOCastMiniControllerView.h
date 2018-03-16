//
//  OOCastMiniControllerView.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 9/9/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOCastMiniControllerProtocol.h"

@class OOCastManager;

@interface OOCastMiniControllerView : UIView<OOCastMiniControllerProtocol>
@property(nonatomic, strong) UITableViewCell *cell;
- (instancetype)initWithFrame:(CGRect)frame castManager:(OOCastManager *)castManager delegate:(id<OOCastMiniControllerDelegate>)delegate;
@end
