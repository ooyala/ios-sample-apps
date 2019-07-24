#import "OOCallbacks.h"
#import "OOEnums.h"

@class OOOoyalaError;

@protocol OOPaginatedParentItem <NSObject>

/**
 * The OOPaginatedParentItem's Embed Code
 * @return the NSString embed code
 */
- (NSString *)embedCode;

/** @internal
 * Update the OOPaginatedParentItem using the specified data
 * @param data the NSDictionary containing the data to use to update this OOPaginatedParentItem
 * @return a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/**
 * Find out it this OOPaginatedParentItem has more children
 * @return YES if it does, NO if it doesn't
 */
- (BOOL)hasMoreChildren;

/** @internal
 * @return the next children token for this OOPaginatedParentItem
 */
- (NSString *)nextChildren;

/**
 * Fetch the additional children if they exist
 * @param callback the OOFetchMoreChildrenCallback to execute when the children are fetched
 * @return YES if more children exist, NO if they don't or they are already in the process of being fetched
 */
- (BOOL)fetchMoreChildren:(OOFetchMoreChildrenCallback)callback;

/**
 * The number of children this OOPaginatedParentItem has.
 * @return an NSUInteger with the number of children
 */
- (NSUInteger)childrenCount;


@end
