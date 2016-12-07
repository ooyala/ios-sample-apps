#import "OOStream.h"

/**
 * Represents a single VAST stream that can be played in a Stream Player.
 * \ingroup vast
 */
@interface OOVASTStream : OOStream {
  BOOL scalable;
  BOOL maintainAspectRatio;
  NSString *vastDeliveryType;
  NSString *apiFramework;
}

@property(readonly, nonatomic) BOOL scalable;                      /**< if this stream is scalable */
@property(readonly, nonatomic) BOOL maintainAspectRatio;           /**< if this stream must maintain the aspect ratio */
@property(readonly, nonatomic, strong) NSString *vastDeliveryType; /**< the vast delivery type of this stream */
@property(readonly, nonatomic, strong) NSString *apiFramework;     /**< the apiFramework of this stream */

/** @internal
 * Initialize a OOStream using the specified VAST MediaFile XML (subclasses should override this)
 * @param[in] xml the OOTBXMLElement containing the xml to use to initialize this OOStream
 * @returns the initialized OOStream
 */
- (id)initWithXML:(OOTBXMLElement *)xml;

@end
