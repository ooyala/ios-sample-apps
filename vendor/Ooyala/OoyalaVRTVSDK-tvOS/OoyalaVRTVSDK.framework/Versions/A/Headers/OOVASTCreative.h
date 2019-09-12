#import "OOTBXML.h"

@class OOVASTLinearAd;
@class OOVASTCompanionAds;
@class OOVASTNonLinearAds;

/**
 * A creative that was defined in a VAST XML
 * \ingroup vast
 */
@interface OOVASTCreative : NSObject

@property (readonly, nonatomic) NSInteger sequence;
@property (readonly, nonatomic) NSString *creativeId;
@property (readonly, nonatomic) NSString *adId;
@property (readonly, nonatomic) OOVASTLinearAd *linear;
@property (readonly, nonatomic) OOVASTCompanionAds *companionAds;
@property (readonly, nonatomic) OOVASTNonLinearAds *nonLinearAds;

- (instancetype)initWithElement:(OOTBXMLElement *)element;
- (BOOL)hasLinear;
- (BOOL)hasCompanionAds;
- (BOOL)hasNonLinearAds;

@end
