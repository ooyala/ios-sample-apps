#import "OOTBXML.h"

typedef NS_ENUM(NSInteger, OORequiredType) {
  OORequiredTypeAll,
  OORequiredTypeAny,
  OORequiredTypeNone
};
  
/**
 * A list of companion ads that was defined in a VAST XML
 * \ingroup vast
 */
@interface OOVASTCompanionAds : NSObject

- (instancetype)initWithElement:(OOTBXMLElement *)element;

@property (readonly, nonatomic) OORequiredType required;
@property (readonly, nonatomic) NSMutableArray *companions;

@end
