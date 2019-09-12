#import "OOTBXML.h"

@class OOVASTResource;

/**
 * A single non-linear, static advertisement that was defined in a VAST XML
 * \ingroup vast
 */
@interface OOVASTNonLinear : NSObject

@property (readonly, nonatomic) NSString *nonLinearId;
@property (readonly, nonatomic) NSInteger width;
@property (readonly, nonatomic) NSInteger height;
@property (readonly, nonatomic) NSInteger expandedWidth;
@property (readonly, nonatomic) NSInteger expandedHeight;
@property (readonly, nonatomic) BOOL scalable;
@property (readonly, nonatomic) BOOL maintainAspectRatio;

@property (readonly, nonatomic) NSInteger minSuggestedDuration;
@property (readonly, nonatomic) NSString *apiFramework;
@property (readonly, nonatomic) OOVASTResource *resource;
@property (readonly, nonatomic) NSMutableArray *clickTrackings;
@property (readonly, nonatomic) NSString *clickThrough;
@property (readonly, nonatomic) OOTBXMLElement *creativeExtensions;
@property (readonly, nonatomic) NSString *parameters;

- (instancetype)initWithElement:(OOTBXMLElement *)element;

@end
