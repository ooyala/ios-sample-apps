#import <Foundation/Foundation.h>
#import "OOTBXML.h"

/**
 * Various VMAP-related utilities
 * \ingroup vast
 */
@interface OOVASTVMAPAdHelper : NSObject

+ (BOOL)parse:(OOTBXMLElement *)e adSpots:(NSMutableArray *)adSpots duration:(NSInteger)duration;
+ (OOTBXMLElement *)firstElement:(OOTBXMLElement *)e byName:(NSString *)name;
@end
