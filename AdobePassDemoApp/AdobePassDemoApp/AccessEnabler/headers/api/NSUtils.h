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

@interface NSUtils : NSObject

+ (NSString *)base64Encoding:(NSData *)data;
+ (NSData *)base64Decoding:(NSString *)string outputLength:(long *)len;
+ (NSString *)sha1:(NSString*)input;
+ (NSString *)sha256:(NSString *)clear;
+ (NSString *)md5:(NSString *)input;
+ (NSString *)trimSpaces:(NSString *)string;
+ (NSString *)htmlEntityDecode:(NSString *)string;
+ (NSString *)htmlEntityEncode:(NSString *)string;
+ (NSString *)urlEncodeString:(NSString *)string;
+ (NSString *)urlDecodeString:(NSString *)string;
+ (NSString *)extractElement:(NSString *)element fromXml:(NSString *)xml;

@end
