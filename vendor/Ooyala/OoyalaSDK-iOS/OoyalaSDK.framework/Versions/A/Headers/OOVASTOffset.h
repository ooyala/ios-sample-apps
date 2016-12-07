#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OffsetType) {
  OffsetTypeSeconds,
  OffsetTypePercentage,
  OffsetTypePosition
};

/**
 * Defines an offset for when ad-related events should happen around VAST ads
 * \ingroup vast
 */
@interface OOVASTOffset : NSObject

@property (readonly, nonatomic, assign) OffsetType type;

- (id)initWithType:(OffsetType)type value:(Float64)value;
- (id)initWithOffset:(NSString *)offsetStr;

- (Float64)getPercentage;
- (Float64)getSeconds;
- (NSInteger)getPosition;
@end
