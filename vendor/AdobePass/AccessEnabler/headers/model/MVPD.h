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

@interface MVPD : NSObject {
    
@private
    NSString *ID;
    NSString *displayName;
    NSString *logoURL;
    NSString *spUrl;
}

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, retain) NSString *logoURL;
@property (nonatomic, retain) NSString *spUrl;
@property (nonatomic, assign) BOOL hasAuthNPerRequestor;
@property (nonatomic, assign) BOOL passiveAuthnEnabled;

- (NSString *)toString;

@end