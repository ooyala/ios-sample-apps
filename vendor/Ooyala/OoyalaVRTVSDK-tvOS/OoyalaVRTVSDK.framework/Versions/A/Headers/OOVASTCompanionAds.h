#import <Foundation/Foundation.h>
#import "OOTBXML.h"

typedef NS_ENUM(NSInteger, RequiredType) {
  RequiredTypeAll,
  RequiredTypeAny,
  RequiredTypeNone
};
  
/**
 * A list of companion ads that was defined in a VAST XML
 * \ingroup vast
 */
@interface OOVASTCompanionAds : NSObject

- (id)initWithElement:(OOTBXMLElement *)element;

@property (readonly, nonatomic) RequiredType required;
@property (readonly, nonatomic, strong) NSMutableArray *companions;

@end
