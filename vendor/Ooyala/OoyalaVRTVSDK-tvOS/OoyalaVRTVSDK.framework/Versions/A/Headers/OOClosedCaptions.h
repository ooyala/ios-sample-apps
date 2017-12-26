#import <Foundation/Foundation.h>
#import "OOReturnState.h"

@class OOCaption;

/**
 * An object which represents all closed captions information for the asset
 * \ingroup item
 */
@interface OOClosedCaptions : NSObject

/** List of available langauges */
@property(readonly, nonatomic) NSArray *languages;
/** Default close caption langauge */
@property(readonly, nonatomic) NSString *defaultLanguage;
/** URL of the close captions source file */
@property(readonly, nonatomic, strong) NSURL *url;
/** the vtt caption dictionary*/
@property(readonly, nonatomic, strong) NSDictionary *vttCaptions;

- (instancetype)init __attribute__((unavailable("use initWithDictionary:")));

/**
 * INTERNAL
 * @internal
 * Initialize a OOClosedCaptions using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOClosedCaptions
 * @returns the initialized OOClosedCaptions
 */
- (instancetype)initWithDictionary:(NSDictionary *)data;

/**
 * INTERNAL
 * @internal
 * Update the OOClosedCaptions using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OOClosedCaptions
 * @returns a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/**
 * INTERNAL
 * @internal
 * Update the OOClosedCaptions using the vtt data
 * @param[in] data the NSDictionary containing the data to use to update this OOClosedCaptions
 */
- (void)updateWithVttDictionary:(NSDictionary *)data;

/**
 * INTERNAL
 * @internal
 * Fetch the closed captions information from the url
 * @returns YES if the fetch succeeded, NO if not
 */
- (BOOL)fetchClosedCaptionsInfo;

/**
 * Fetch the closed captions for the given language
 * @param[in] language the language to fetch (if nil, empty, or not on languages, defaultLanguage will be used)
 * @returns and NSArray containing the OOCaption objects
 */
- (NSArray *)closedCaptionsForLanguage:(NSString *)language;

/**
 * Fetch the OOCaption for a given language at the given time (in milliseconds)
 * @param[in] language the language for which to fetch the OOCaption
 * @param[in] time the time in seconds
 * @returns the OOCaption if it exists for that language and time combination, nil otherwise
 */
- (OOCaption *)captionForLanguage:(NSString *)language time:(Float64)time;

@end
