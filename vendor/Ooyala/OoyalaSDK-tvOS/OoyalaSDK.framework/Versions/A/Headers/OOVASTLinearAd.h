#import <Foundation/Foundation.h>
#import "OOTBXML.h"
#import "OOPlayableItem.h"

/**
 * Represents a single VAST linear advertisement.
 * \ingroup vast
 */
@interface OOVASTLinearAd : NSObject <OOPlayableItem> 

@property (readonly, nonatomic) NSMutableArray *icons;
@property (readonly, nonatomic) Float64 skipoffset;
@property (readonly, nonatomic) Float64 duration;                    /**< The duration of the ad in seconds */
@property (readonly, nonatomic) NSMutableDictionary *trackingEvents; /**< The tracking events in an NSMutableDictionary of event name to NSMutableArray of NSString */
@property (readonly, nonatomic) NSString *parameters;                /**< The additional ad parameters */
@property (readonly, nonatomic) NSString *clickThroughURL;           /**< The click through url */
@property (readonly, nonatomic) NSMutableArray *clickTrackingURLs;   /**< The click tracking urls in an NSMutableArray of NSString */
@property (readonly, nonatomic) NSMutableArray *customClickURLs;     /**< The custom click urls in an NSMutableArray of NSString */
@property (readonly, nonatomic) NSMutableArray *streams;             /**< The streams in an NSMutableArray of OOStream */
@property (readonly, nonatomic) NSMutableArray *errorCodes;          /**< The error codes */

/** @internal
 * Initialize a OOVASTLinearAd using the specified xml (subclasses should override this)
 * @param xml the OOTBXMLElement containing the xml to use to initialize this OOVASTLinearAd
 * @return the initialized OOVASTLinearAd
 */
- (id)initWithXML:(OOTBXMLElement *)xml;

/** @internal
 * Update the tracking events of the inline linear ad by adding the new tracking events of the wrapper ad
 * @param newTrackingEvents the NSMutableDictionary of the wrapper's tracking events
 */
- (void)updateTrackingEvents:(NSMutableDictionary*)newTrackingEvents;

/** @internal
 * Update the click tracking URLs of the inline linear ad by adding the new click tracking URLs of the wrapper ad
 * @param newClickTrackingURLs the NSMutableArray of the wrapper's click tracking URLs
 */
- (void)updateClickTrackingURLs:(NSMutableArray*)newClickTrackingURLs;

- (void)merge:(OOVASTLinearAd *)linear;

@end
