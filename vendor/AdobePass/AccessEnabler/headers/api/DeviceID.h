#import <Foundation/Foundation.h>

@interface DeviceID : NSObject

+ (NSString*) getID;
+ (void) resetID;
+ (BOOL) isTokenFingerprintValid:(NSString*)fingerprint;

@end
