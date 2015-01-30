/*
 *  DRMInterface.h
 *
 *  ADOBE SYSTEMS INCORPORATED
 *  Copyright 2011-2012 Adobe Systems Incorporated 
 *  All Rights Reserved.
 *  
 *  NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the 
 *  terms of the Adobe license agreement accompanying it.  If you have received this file from a 
 *  source other than Adobe, then your use, modification, or distribution of it requires the prior written 
 *  permission of Adobe.
 */
#ifndef DRMINTERFACE_H
#define DRMINTERFACE_H

#include <Foundation/Foundation.h>

// ---------------- Start Declarations ----------------

@class DRMLicense;
@class DRMMetadata;
@class DRMLicenseDomain;
@class DRMPlaybackTimeWindow;
@class DRMSession;

#pragma mark Declarations
typedef void (^DRMOperationError)(NSUInteger majorCode, NSUInteger minorCode, NSError* platformError);
typedef void (^DRMOperationComplete)();
typedef void (^DRMLicenseAcquired)(DRMLicense* license);
typedef void (^DRMPlaylistUpdated)(NSURL * playlist, DRMMetadata * metadata);
typedef void (^DRMAuthenticationComplete)(NSData* authenticationToken);


typedef enum
{
	UNKNOWN = 0,
	ANONYMOUS = 1,
	USERNAME_AND_PASSWORD = 2
} DRMAuthenticationMethod;

typedef enum
{
	FORCE_REFRESH = 0, // The License is always downloaded from the media rights server.
	LOCAL_ONLY = 1,    // The License is only loaded from the local cache.
	ALLOW_SERVER = 2,  // The License is loaded from the local cache if possible, but otherwise is downloaded from the server.
} DRMAcquireLicenseSettings;

#pragma mark -
// ---------------- End Declarations ----------------

// ---------------- Start Interfaces ----------------
__attribute__((visibility("default")))
@interface DRMManager : NSObject
// This property controls the maximum amount of time a DRM operation is allowed to take. 
// If the operation would take longer, it fails with a timeout error.
@property(nonatomic, readwrite, getter=getMaxOperationTime, setter=setMaxOperationTime:) NSUInteger maxOperationTime;

// Returns the singleton DRMManager instance
+(DRMManager*) sharedManager;

-(void) setAuthenticationToken:(DRMMetadata*)metadata authenticationDomain:(NSString*)authenticationDomain token:(NSData*)token error:(DRMOperationError)error complete:(DRMOperationComplete)complete;
-(void) authenticate:(DRMMetadata*)metadata url:(NSString*)serverURL authenticationDomain:(NSString*)authenticationDomain username:(NSString*)username password:(NSString*)password error:(DRMOperationError)error complete:(DRMAuthenticationComplete)complete;

// We do not need to specify the DRMPolicy to use as all policies are currently used
-(void) acquirePreviewLicense:(DRMMetadata*)contentData error:(DRMOperationError)error acquired:(DRMLicenseAcquired)acquired;
-(void) acquireLicense:(DRMMetadata*)contentData setting:(DRMAcquireLicenseSettings)setting error:(DRMOperationError)error acquired:(DRMLicenseAcquired)acquired;
-(void) storeLicenseBytes:(NSData*)licenseBytes error:(DRMOperationError)error complete:(DRMOperationComplete)complete;
-(void) resetDRM:(DRMOperationError)error complete:(DRMOperationComplete)complete;

-(void) joinLicenseDomain:(DRMLicenseDomain*)licenseDomain forceRefresh:(BOOL)forceRefresh error:(DRMOperationError)error complete:(DRMOperationComplete)complete;
-(void) leaveLicenseDomain:(DRMLicenseDomain*)licenseDomain error:(DRMOperationError)error complete:(DRMOperationComplete)complete;

// DRMSession returned must be released after video playback is complete
// The error callback may be called during the lifetime of the DRMSession
// The complete callback occurs when the license has been downloaded
-(DRMSession*) createDRMSession:(DRMMetadata*)metadata playlist: (NSURL*) playlist error:(DRMOperationError)error complete:(DRMOperationComplete)complete;

// These calls are iOS specific
-(BOOL) isSupportedPlaylist:(NSURL*)url;
-(void) getUpdatedPlaylist:(NSURL*)url error:(DRMOperationError)error updated:(DRMPlaylistUpdated)updated;
@end // DRMManager

__attribute__((visibility("default")))
@interface DRMMetadata : NSObject
@property(nonatomic, readonly, retain, getter=getServerUrl) NSString* serverUrl;
@property(nonatomic, readonly, retain, getter=getLicenseId) NSString* licenseId;
@property(nonatomic, readonly, retain, getter=getPolicies) NSArray* policies; // Contains DRMPolicy objects

- (id) initFromNSData:(NSData*)rawData error:(DRMOperationError)error;
@end // DRMMetadata

__attribute__((visibility("default")))
@interface DRMPolicy : NSObject
@property(nonatomic, readonly, retain, getter=getDisplayName) NSString* displayName;
@property(nonatomic, readonly, getter=getAuthenticationMethod) DRMAuthenticationMethod authenticationMethod;
@property(nonatomic, readonly, retain, getter=getAuthenticationDomain) NSString* authenticationDomain;
@property(nonatomic, readonly, retain, getter=getLicenseDomain) DRMLicenseDomain* licenseDomain;
@end // DRMPolicy

__attribute__((visibility("default")))
@interface DRMLicenseDomain : NSObject
@property(nonatomic, readonly, getter=getAuthenticationMethod) DRMAuthenticationMethod authenticationMethod;
@property(nonatomic, readonly, retain, getter=getAuthenticationDomain) NSString* authenticationDomain;
@property(nonatomic, readonly, retain, getter=getServerUrl) NSString* serverUrl;
@end // DRMLicenseDomain

__attribute__((visibility("default")))
@interface DRMLicense : NSObject
// Returns NSString:NSData pairs
@property(nonatomic, readonly, retain, getter=getCustomProperties) NSDictionary* customProperties;

// This is the fixed period during which the license can be used
@property(nonatomic, readonly, retain, getter=getLicenseStartDate) NSDate* licenseStartDate;
@property(nonatomic, readonly, retain, getter=getLicenseEndDate) NSDate* licenseEndDate;

// This is the fixed period during which the license can be stored to disk
@property(nonatomic, readonly, retain, getter=getOfflineStorageStartDate) NSDate* offlineStorageStartDate;
@property(nonatomic, readonly, retain, getter=getOfflineStorageEndDate) NSDate* offlineStorageEndDate;

// This is the calculated period during which the license has been used and the maximum period allowed for usage
@property(nonatomic, readonly, retain, getter=getPlaybackTimeWindow) DRMPlaybackTimeWindow* playbackTimeWindow;

// TODO: currently can't create DRMVoucher from rawData, why was this exposed?
//- (id) initFromNSData:(NSData*)rawData;

- (NSData*) toNSData;
@end // DRMLicense

__attribute__((visibility("default")))
@interface DRMPlaybackTimeWindow : NSObject
@property(nonatomic, readonly, getter=getPlaybackPeriodInSeconds) NSUInteger playbackPeriodInSeconds;
@property(nonatomic, readonly, retain, getter=getPlaybackStartDate) NSDate * playbackStartDate;
@property(nonatomic, readonly, retain, getter=getPlaybackEndDate) NSDate * playbackEndDate;
@end // DRMPlaybackTimeWindow

// ---------------- End Interfaces ----------------

#endif // DRMINTERFACE_H
