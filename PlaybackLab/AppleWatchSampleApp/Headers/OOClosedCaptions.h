/**
 * @class      OOClosedCaptions OOClosedCaptions.h "OOClosedCaptions.h"
 * @brief      OOClosedCaptions
 * @details    OOClosedCaptions.h in OoyalaSDK
 * @date       12/12/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOReturnState.h"

@class OOCaption;

/**
 * A set of `OOCaption`s associated with specific content movie
 */
@interface OOClosedCaptions : NSObject {
@protected
  NSMutableArray *languages;
  NSURL *url;
  NSString *defaultLanguage;
}

/** List of available langauges */
@property(readonly, nonatomic, strong) NSMutableArray *languages;
/** Default close caption langauge */
@property(readonly, nonatomic, strong) NSString *defaultLanguage;
/** URL of the close captions source file */
@property(readonly, nonatomic, strong) NSURL *url;

/**
 * INTERNAL
 * @internal
 * Initialize a OOClosedCaptions using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOClosedCaptions
 * @returns the initialized OOClosedCaptions
 */
- (id)initWithDictionary:(NSDictionary *)data;

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
