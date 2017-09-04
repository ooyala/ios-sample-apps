#define LOG(...) [OODebugMode log:[NSString stringWithUTF8String:__FILE__] message:__VA_ARGS__];
#define ASSERT(condition, ...) [OODebugMode assert:condition tag:[NSString stringWithUTF8String:__FILE__] message:__VA_ARGS__];
#define ASSERT_FALSE(...) [OODebugMode assertFalse:[NSString stringWithUTF8String:__FILE__] message:__VA_ARGS__];

#import <Foundation/Foundation.h>

typedef enum {
  None,
  LogOnly,
  LogAndAbort
} DebugMode;

/**
 * Enable or disable Ooyala debug logs
 * \ingroup key
 */
@interface OODebugMode : NSObject

/**
 * gets current debug mode.
 * @returns debug mode
 */
+ (DebugMode)getDebugMode;

/**
 * sets the debug mode.
 * @param[in] mode the debug mode to be set
 * @returns YES if nil, NULL, or empty, NO if not
 */
+ (void)setDebugMode:(DebugMode)mode;

/**
 * assert a certain condition
 * @param[in] condition the condition to test
 * @param[in] tag the tag of the component
 * @param[in] format of the message
 */
+ (void)assert:(BOOL)condition tag:(NSString *)tag message:(NSString *)format, ...;

/**
 * helper function to assert a false condition
 * @param[in] tag
 * @param[in] format of the message
 */
+ (void)assertFalse:(NSString *)tag message:(NSString *)format, ...;

/**
 * log if the debug mode is not none, ignore otherwise
 * @param[in] tag: the tag
 * @param[in] format of the message
 */
+ (void)log:(NSString *)tag message:(NSString *)format, ...;

@end
