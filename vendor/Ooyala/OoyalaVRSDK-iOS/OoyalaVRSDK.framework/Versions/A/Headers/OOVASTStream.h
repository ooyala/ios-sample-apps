#import "OOStream.h"
#import "OOTBXML.h"

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

@property (readonly, nonatomic) BOOL scalable;                      /**< if this stream is scalable */
@property (readonly, nonatomic) BOOL maintainAspectRatio;           /**< if this stream must maintain the aspect ratio */
@property (readonly, nonatomic) NSString *vastDeliveryType; /**< the vast delivery type of this stream */
@property (readonly, nonatomic) NSString *apiFramework;     /**< the apiFramework of this stream */

/** @internal
 * Initialize a OOStream using the specified VAST MediaFile XML (subclasses should override this)
 * @param xml the OOTBXMLElement containing the xml to use to initialize this OOStream
 * @return the initialized OOStream
 */
- (instancetype)initWithXML:(OOTBXMLElement *)xml;

@end
