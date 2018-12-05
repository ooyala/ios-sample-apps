//
//  OOReactSkinBridgeModule.h
//  OoyalaSkinSDK
//
//  Created by Maksim Kupetskii on 8/14/18.
//  Copyright © 2018 ooyala. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import "OOReactSkinModel.h"

// We can add more modules if needed
typedef NS_ENUM(NSInteger, OOReactSkinBridgeModuleType) {
  OOReactSkinBridgeModuleTypeMain
};

NS_ASSUME_NONNULL_BEGIN

@protocol OOReactSkinBridgeModule <RCTBridgeModule>

@required
- (void)setSkinViewDelegate:(id<OOReactSkinModelDelegate>) skinModelDelegate;
- (OOReactSkinBridgeModuleType)moduleType;

@end

NS_ASSUME_NONNULL_END
