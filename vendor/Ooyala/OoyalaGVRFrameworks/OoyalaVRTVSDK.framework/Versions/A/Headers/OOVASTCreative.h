#import <Foundation/Foundation.h>
#import "OOTBXML.h"
#import "OOVASTLinearAd.h"
#import "OOVASTCompanionAds.h"
#import "OOVASTNonLinearAds.h"

/**
 * A creative that was defined in a VAST XML
 * \ingroup vast
 */
@interface OOVASTCreative : NSObject

@property (readonly, nonatomic) NSInteger sequence;
@property (readonly, nonatomic, strong) NSString *id;
@property (readonly, nonatomic, strong) NSString *adId;
@property (readonly, nonatomic, strong) OOVASTLinearAd *linear;
@property (readonly, nonatomic, strong) OOVASTCompanionAds *companionAds;
@property (readonly, nonatomic, strong) OOVASTNonLinearAds *nonLinearAds;

- (id)initWithElement:(OOTBXMLElement *)element;
- (BOOL)hasLinear;
- (BOOL)hasCompanionAds;
- (BOOL)hasNonLinearAds;

@end
