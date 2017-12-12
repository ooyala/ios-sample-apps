
@interface OODeviceInfo : NSObject

@property NSString *browser;
@property NSString *browserVersion;
@property NSString *os;
@property NSString *osVersion;
@property NSString *deviceType;
@property NSString *deviceBrand;
@property NSString *model;

- (OODeviceInfo *)initWithBrowser: (NSString*) browser browserVersion: (NSString*) browserVersion os: (NSString*) os osVersion: (NSString*) osVersion deviceBrand: (NSString*) deviceBrand model: (NSString*) model;

@end
