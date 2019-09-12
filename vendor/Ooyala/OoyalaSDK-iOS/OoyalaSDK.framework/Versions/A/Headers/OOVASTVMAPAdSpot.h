#import "OOVASTAdSpot.h"

@class OOVASTOffset;

/**
 * Defines all information around an Ad Spot as it was defined in a VMAP XML
 * \ingroup vast
 */
@interface OOVASTVMAPAdSpot : OOVASTAdSpot

@property (readonly, nonatomic) OOVASTOffset *timeOffset;
@property (readonly, nonatomic) NSString *breakType;
@property (readonly, nonatomic) NSString *breakId;
@property (readonly, nonatomic) NSString *adSourceId;
@property (readonly, nonatomic) BOOL allowMultipleAds;
@property (readonly, nonatomic) BOOL followRedirects;

- (instancetype)initWithOffset:(OOVASTOffset *)timeOffset
                      duration:(NSInteger)duration
                   repeatAfter:(Float64)repeatAfter
                     breakType:(NSString *)breakType
                       breakId:(NSString *)breakId
                      sourceId:(NSString *)sourceId
              allowMultipleAds:(BOOL)allowMultipleAds
               followRedirects:(BOOL)followRedirects
                       element:(OOTBXMLElement *)element;

- (instancetype)initWithOffset:(OOVASTOffset *)timeOffset
                      duration:(NSInteger)duration
                   repeatAfter:(Float64)repeatAfter
                     breakType:(NSString *)breakType
                       breakId:(NSString *)breakId
                      sourceId:(NSString *)sourceId
              allowMultipleAds:(BOOL)allowMultipleAds
               followRedirects:(BOOL)followRedirects
                       vastUrl:(NSURL *)vastUrl;

/**
 * return true if VMAP ad is repeatable, otherwise not
 */
- (BOOL)isRepeatable;

/**
 * mark the ad spot as played
 */
- (void)markAsPlayed;

/**
 * mark the ad spot as unplayed
 */
- (void)markAsUnplayed;

@end
