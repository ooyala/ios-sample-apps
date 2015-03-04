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

@interface AuthenticationToken : NSObject {
    
@private
    NSString *requestorId;
    NSString *mvpdId;
    NSString *xml;
    NSString *sessionGuid;
    NSString *nameId;
    NSString *sessionIndex;
    NSString *expiresDate;
    NSString *simpleTokenFingerprint;
    NSArray *preAuthorizedResources;
}

@property (nonatomic, retain) NSString *requestorId;
@property (nonatomic, retain) NSString *mvpdId;
@property (nonatomic, retain) NSString *xml;
@property (nonatomic, retain) NSString *sessionGuid;
@property (nonatomic, retain) NSString *nameId;
@property (nonatomic, retain) NSString *sessionIndex;
@property (nonatomic, retain) NSString *expiresDate;
@property (nonatomic, retain) NSString *simpleTokenFingerprint;
@property (nonatomic, retain) NSArray *preAuthorizedResources;

- (BOOL)isValid;

@end
