#import <Foundation/Foundation.h>
#import "Mvpd.h"

@protocol EntitlementDelegate <NSObject>

- (void) setRequestorComplete:(int)status;
- (void) setAuthenticationStatus:(int)status errorCode:(NSString *)code;
- (void) setToken:(NSString *)token forResource:(NSString *)resource;
- (void) preauthorizedResources:(NSArray *)resources;
- (void) tokenRequestFailed:(NSString *)resource errorCode:(NSString *)code errorDescription:(NSString *)description;
- (void) selectedProvider:(MVPD *)mvpd;
- (void) displayProviderDialog:(NSArray *)mvpds;
- (void) sendTrackingData:(NSArray *)data forEventType:(int)event;
- (void) setMetadataStatus:(id)metadata encrypted:(BOOL)encrypted forKey:(int)key andArguments:(NSDictionary *)arguments;
- (void) navigateToUrl:(NSString *)url;

@end


