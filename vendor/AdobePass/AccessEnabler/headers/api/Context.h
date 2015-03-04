/**
 * **********************************************************************
 * <p/>
 * ADOBE CONFIDENTIAL
 * ___________________
 * <p/>
 * Copyright 2011 Adobe Systems Incorporated
 * All Rights Reserved.
 * <p/>
 * NOTICE:  All information contained herein is, and remains
 * the property of Adobe Systems Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Adobe Systems Incorporated and its
 * suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Adobe Systems Incorporated.
 * ************************************************************************
 */
#import <Foundation/Foundation.h>
#import "ConnectionsManager.h"

#define MOCK_CONNECTIONS_MANAGER_COMPONENTS     @"mockConnectionsManagerComponents"

typedef enum {PASSIVE_STOPPED, PASSIVE_WEBVIEW_AUTHN, PASSIVE_TOKEN_RETRIEVAL} PassiveAuthnState;

@class ConnectionsManager;

@interface Context : NSObject {
    
@private
    StorageManager *storageManager;
    CookieManager *cookieManager;
    ConnectionsManager *connectionsManager;
    Requestor *requestor;
    NSMutableDictionary *deviceInfo;
    UserMetadata *metadataCache;
    NSMutableArray *metadataCallQueue;
    NSString *signedRequestorId;
    BOOL getAuthenticationWasCalled;
    BOOL setSelectedProviderWasCalled;
    PassiveAuthnState passiveAuthnState;
}

@property (nonatomic, retain) StorageManager *storageManager;
@property (nonatomic, retain) CookieManager *cookieManager;
@property (nonatomic, retain) ConnectionsManager *connectionsManager;
@property (nonatomic, retain) Requestor *requestor;
@property (nonatomic, retain) NSMutableDictionary *deviceInfo;
@property (nonatomic, retain) UserMetadata *metadataCache;
@property (nonatomic, retain) NSMutableArray *metadataCallQueue;
@property (nonatomic, retain) NSString *signedRequestorId;
@property (nonatomic, assign) BOOL getAuthenticationWasCalled;
@property (nonatomic, assign) BOOL setSelectedProviderWasCalled;
@property (nonatomic, assign) PassiveAuthnState passiveAuthnState;

#ifdef UNIT_TEST_MODE
- (void)installMockComponents:(NSDictionary *)components;
#endif

@end
