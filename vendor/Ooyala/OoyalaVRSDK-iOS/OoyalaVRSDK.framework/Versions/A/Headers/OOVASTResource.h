@import Foundation;

typedef NS_ENUM(NSInteger, OOResourceType) {
  OOResourceTypeNone,
  OOResourceTypeStatic,
  OOResourceTypeIFrame,
  OOResourceTypeHTML
};

/**
 * A URL from which to get VAST information
 * \ingroup vast
 */
@interface OOVASTResource : NSObject

@property (readonly, nonatomic) OOResourceType type;
@property (readonly, nonatomic) NSString *uri;
@property (readonly, nonatomic) NSString *mimeType;

- (instancetype)initWithType:(OOResourceType)type
                    mimeType:(NSString *)mimeType
                         uri:(NSString *)uri;

- (NSString *)typeToStr:(OOResourceType)type;

@end
