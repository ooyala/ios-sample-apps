//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOCastManager.h"

@interface OOCastManagerDeviceReconnector : NSObject
@property(nonatomic) BOOL automaticallyReconnect;
-(id) init __attribute__((unavailable("use initWithCastManager:")));
-(instancetype) initWithCastManager:(OOCastManager*)castManager;
-(void) onDeviceIPChanged:(NSString*)deviceIP;
-(void) deviceDidComeOnline:(GCKDevice*)device;
-(void) forgetDevice;
@end