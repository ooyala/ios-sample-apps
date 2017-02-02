//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOCastManager.h"

@interface OOCastManagerDeviceReconnector : NSObject
@property (nonatomic) BOOL automaticallyReconnect;
@property (nonatomic, readonly) BOOL isReconnecting;
@property (nonatomic, readonly) NSString *lastSessionID;
-(id) init __attribute__((unavailable("use initWithCastManager:")));
-(instancetype) initWithCastManager:(OOCastManager*)castManager;
-(void) rememberDevice:(GCKDevice*)device sessionID:(NSString*)sessionID;
-(void) deviceDidComeOnline:(GCKDevice*)device;
-(void) didFailToConnectWithError:(NSError*)error;
-(void) didFailToConnectToApplicationWithError:(GCKError*)error;
-(BOOL) didDisconnectWithError:(GCKError*)error;
-(void)forgetReconnectionInfo;
@end