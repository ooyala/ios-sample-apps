@import Foundation;

typedef NS_ENUM(NSInteger, OOOffsetType) {
  OOOffsetTypeSeconds,
  OOOffsetTypePercentage,
  OOOffsetTypePosition
};

/**
 * Defines an offset for when ad-related events should happen around VAST ads
 * \ingroup vast
 */
@interface OOVASTOffset : NSObject

@property (readonly, nonatomic) OOOffsetType type;

- (instancetype)initWithType:(OOOffsetType)type value:(Float64)value;
- (instancetype)initWithOffset:(NSString *)offsetStr;

- (Float64)percentage;
- (Float64)seconds;
- (NSInteger)position;

@end
