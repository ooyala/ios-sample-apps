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

@protocol NSURLConnectionWithTagProtocol

- (void)createWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately
                      tag:(NSNumber*)_tag;
- (void)createWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately
                      tag:(NSNumber*)_tag isPassiveAuthn:(BOOL)passiveAuthn;
- (void)createWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately
                      tag:(NSNumber*)_tag shortMediaResourceID:(NSString *)_shortMediaResourceID;
- (void)createWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately
                      tag:(NSNumber*)_tag spUrl:(NSString*)_spUrl;
- (void)createWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately
                      tag:(NSNumber*)_tag metadataInfo:(NSDictionary*)_metadataInfo;

@end


@class NSURLConnectionWrapper;


@interface NSURLConnectionWithTag : NSObject<NSURLConnectionWithTagProtocol> {
    
@private    
    NSURLConnectionWrapper *urlConnection;
    NSString *local_shortMediaResourceID; 
    NSString *local_spUrl;
    NSNumber *local_tag;
    NSDictionary *local_metadataInfo;
    NSString *local_connectionID;
    BOOL local_passiveAuthn;
}

@property (nonatomic, retain) NSURLConnectionWrapper *urlConnection;

- (NSNumber*)tag;
- (NSString*)shortMediaResourceID;
- (NSString*)spUrl;
- (NSDictionary*)metadataInfo;
- (NSString*)connectionID;
- (BOOL)passiveAuthn;

- (void)setTag:(NSNumber*) tag;
- (void)setShortMediaResourceID:(NSString*) shortMediaResourceID;
- (void)setSpUrl:(NSString*) spUrl;
- (void)setMetadataInfo:(NSDictionary*) metadataInfo;
- (void)setConnectionID:(NSString*) connectionID;
- (void)setPassiveAuthn:(BOOL) passiveAuthn;

@end


// helper class
@interface NSURLConnectionWrapper : NSURLConnection {
    
@private    
	NSNumber *tag;
    NSString *shortMediaResourceID; 
    NSString *spUrl;
    NSDictionary *metadataInfo;
    NSString *connectionID;
    BOOL passiveAuthn;
}

@property (nonatomic, retain) NSNumber *tag;
@property (nonatomic, retain) NSString *shortMediaResourceID;
@property (nonatomic, retain) NSString *spUrl;
@property (nonatomic, retain) NSDictionary *metadataInfo;
@property (nonatomic, retain) NSString *connectionID;
@property (nonatomic, assign) BOOL passiveAuthn;

@end

