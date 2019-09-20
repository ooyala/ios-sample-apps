@import Foundation;

@class OOCaption;
@class OOContentTreeCC;
@class OOContentTreeVTT;

/**
 * An object which represents all closed captions information for the asset
 * \ingroup item
 */
@interface OOClosedCaptions : NSObject

/** List of available langauges */
@property (readonly, nonatomic) NSArray *languages;
/** Default close caption langauge */
@property (readonly, nonatomic) NSString *defaultLanguage;
/** URL of the close captions source file */
@property (readonly, nonatomic) NSURL *url;
/** the vtt caption dictionary*/
@property (readonly, nonatomic) NSDictionary *vttCaptions;

- (instancetype)init __attribute__((unavailable("use initWithContentTreeCC:")));

/**
 * INTERNAL
 * @internal
 * Initialize a OOClosedCaptions using the specified data (subclasses should override this)
 * @param contentTreeCC a @c OOContentTreeCC fetched in content_tree response
 * @param embedCode an embed code to use
 * @return the initialized OOClosedCaptions
 */
- (instancetype)initWithContentTreeCC:(OOContentTreeCC *)contentTreeCC
                         andEmbedCode:(NSString *)embedCode;

/**
 * INTERNAL
 * @internal
 * Update the OOClosedCaptions using the specified data (subclasses should override and call this)
 * @param contentTreeVTT a @c OOContentTreeVTT fetched in content_tree response
 */
- (void)updateWithContentTreeVTT:(OOContentTreeVTT *)contentTreeVTT;

/**
 * INTERNAL
 * @internal
 * Fetch the closed captions information from the url
 * @return YES if the fetch succeeded, NO if not
 */
- (BOOL)fetchClosedCaptionsInfo;

/**
 * Fetch the closed captions for the given language
 * @param language the language to fetch (if nil, empty, or not on languages, defaultLanguage will be used)
 * @return and NSArray containing the OOCaption objects
 */
- (NSArray *)closedCaptionsForLanguage:(NSString *)language;

/**
 * Fetch the OOCaption for a given language at the given time (in milliseconds)
 * @param language the language for which to fetch the OOCaption
 * @param time the time in seconds
 * @return the OOCaption if it exists for that language and time combination, nil otherwise
 */
- (OOCaption *)captionForLanguage:(NSString *)language time:(Float64)time;

@end
