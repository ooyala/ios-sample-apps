#import "OOTBXML.h"
#import "OOVASTResource.h"

/**
 * Represents a VASTIcon that needs to be displayed on during a VAST ad
 * \ingroup vast
 */
@interface OOVASTIcon : NSObject

@property (readonly, nonatomic) NSString *program;
@property (readonly, nonatomic) NSInteger width;
@property (readonly, nonatomic) NSInteger height;
@property (readonly, nonatomic) NSInteger xPosition;
@property (readonly, nonatomic) NSInteger yPosition;
@property (readonly, nonatomic) Float64 duration;
@property (readonly, nonatomic) Float64 offset;
@property (readonly, nonatomic) NSString *resourceUrl;
@property (readonly, nonatomic) NSString *creativeType;
@property (readonly, nonatomic) OOResourceType type;
@property (readonly, nonatomic) NSString *apiFramework;
@property (readonly, nonatomic) NSString *clickThrough;

@property (readonly, nonatomic) NSMutableArray *clickTrackings;
@property (readonly, nonatomic) NSMutableArray *viewTrackings;

- (instancetype)initWithXML:(OOTBXMLElement *)xml;

@end
