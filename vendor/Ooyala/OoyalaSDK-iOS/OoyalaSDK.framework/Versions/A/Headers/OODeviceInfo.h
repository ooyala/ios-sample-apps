/**
 @class OODeviceInfo

 The @c OODeviceInfo class is used to provide device-specific info

 @discussion This class stores info about @c browser, @c browserVersion, @c os, @c osversion, @c deviceType, @c deviceBrand and @c model
 */

@import Foundation;

/**
 The @c OODeviceInfo class is used to provide device-specific info
 */
@interface OODeviceInfo : NSObject

@property (nonatomic, nullable) NSString *browser;
@property (nonatomic, nullable) NSString *browserVersion;
@property (nonatomic, nullable) NSString *os;
@property (nonatomic, nullable) NSString *osVersion;
@property (nonatomic, nullable) NSString *deviceType;
@property (nonatomic, nullable) NSString *deviceBrand;
@property (nonatomic, nullable) NSString *model;

/**
 Initializes @c OODeviceInfo with info about current device

 @return an instance of @c OODeviceInfo with current device and defaults
 */
- (nonnull instancetype)init;

/**
 Initializes @c OODeviceInfo with info about current device
 @see @c init;
 @return an instance of @c OODeviceInfo with current device and defaults
 */
+ (nonnull instancetype)current;

/**
 Initializes  @c OODeviceInfo with provided properties

 @param browser name of a browser
 @param browserVersion version of a browser
 @param os name of OS
 @param osVersion version of OS
 @param deviceBrand brand of a device
 @param model model of a device
 @return an instance @c OODeviceInfo with specific arguments
 */
- (nonnull instancetype)initWithBrowser:(nullable NSString *)browser
                         browserVersion:(nullable NSString *)browserVersion
                                     os:(nullable NSString *)os
                              osVersion:(nullable NSString *)osVersion
                            deviceBrand:(nullable NSString *)deviceBrand
                                  model:(nullable NSString *)model;

/**
 Converts current info to dictionary

 @return a dictionary with corresponding keys and values
 */
- (nonnull NSDictionary *)dictionaryView;

/**
 A human-readable device name, i.e. "iPhone XS Max"

 @return a @c NSString containing redable device name
 */
+ (nonnull NSString *)deviceName;

@end
