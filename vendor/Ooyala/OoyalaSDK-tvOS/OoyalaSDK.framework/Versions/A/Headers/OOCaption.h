/**
 * @class      OOCaption OOCaption.h "OOCaption.h"
 * @brief      OOCaption
 * @details    OOCaption.h in OoyalaSDK
 * @date       12/12/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOTBXML.h"

/**
 * Single timed text item
 */
@interface OOCaption : NSObject {
@protected
  Float64 begin;
  Float64 end;
  NSString *text;
}

/** Time when the text should appear */
@property (readonly, nonatomic) Float64 begin;
/** Time when the text should disappear */
@property (readonly, nonatomic) Float64 end;
/** Text string to appear */
@property (readonly, nonatomic) NSString *text;

- (instancetype)initWithBegin:(Float64)begin_ end:(Float64)end_ text:(NSString *)text_;

/** @internal
 * Initialize a OOCaption using the specified xml (subclasses should override this)
 * @param xml the OOTBXMLElement containing the p xml element to use to initialize this OOCaption
 * @return the initialized OOCaption
 */
- (instancetype)initWithXML:(OOTBXMLElement *)xml;

@end
