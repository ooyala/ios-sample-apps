#ifndef OODebugMode_h
#define OODebugMode_h

#define LOG(...) [OODebugMode log:[NSString stringWithUTF8String:__FILE__] message:__VA_ARGS__];
#define ASSERT(condition, ...) [OODebugMode assert:condition tag:[NSString stringWithUTF8String:__FILE__] message:__VA_ARGS__];
#define ASSERT_FALSE(...) [OODebugMode assertFalse:[NSString stringWithUTF8String:__FILE__] message:__VA_ARGS__];

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DebugMode) {
  None,
  LogOnly,
  LogAndAbort
};

/**
 * Enable or disable Ooyala debug logs
 * \ingroup key
 */
@interface OODebugMode : NSObject

/**
 * gets current debug mode.
 * @return debug mode
 */
+ (DebugMode)getDebugMode;

/**
 * sets the debug mode.
 * @param mode the debug mode to be set
 */
+ (void)setDebugMode:(DebugMode)mode;

/**
 * assert a certain condition
 * @param condition the condition to test
 * @param tag the tag of the component
 * @param format of the message
 */
+ (void)assert:(BOOL)condition tag:(NSString *)tag message:(NSString *)format, ...;

/**
 * helper function to assert a false condition
 * @param tag the tag
 * @param format of the message
 */
+ (void)assertFalse:(NSString *)tag message:(NSString *)format, ...;

/**
 * log if the debug mode is not none, ignore otherwise
 * @param tag the tag
 * @param format of the message
 */
+ (void)log:(NSString *)tag message:(NSString *)format, ...;

@end

#endif /* OODebugMode_h */

