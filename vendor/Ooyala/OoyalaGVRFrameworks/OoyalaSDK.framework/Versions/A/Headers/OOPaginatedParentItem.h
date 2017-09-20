#import <Foundation/Foundation.h>
#import "OOCallbacks.h"
#import "OOReturnState.h"

@class OOOoyalaError;

@protocol OOPaginatedParentItem<NSObject>

/**
 * The OOPaginatedParentItem's Embed Code
 * @returns the NSString embed code
 */
- (NSString *)embedCode;

/** @internal
 * Update the OOPaginatedParentItem using the specified data
 * @param[in] data the NSDictionary containing the data to use to update this OOPaginatedParentItem
 * @returns a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/**
 * Find out it this OOPaginatedParentItem has more children
 * @returns YES if it does, NO if it doesn't
 */
- (BOOL)hasMoreChildren;

/** @internal
 * @returns the next children token for this OOPaginatedParentItem
 */
- (NSString *)nextChildren;

/**
 * Fetch the additional children if they exist
 * @param[in] callback the OOFetchMoreChildrenCallback to execute when the children are fetched
 * @returns YES if more children exist, NO if they don't or they are already in the process of being fetched
 */
- (BOOL)fetchMoreChildren:(OOFetchMoreChildrenCallback)callback;

/**
 * The number of children this OOPaginatedParentItem has.
 * @returns an NSUInteger with the number of children
 */
- (NSUInteger)childrenCount;


@end
