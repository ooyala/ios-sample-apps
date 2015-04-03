/**
 * @class      OOOrderedDictionary OOOrderedDictionary.h "OOOrderedDictionary.h"
 * @brief      OOOrderedDictionary
 * @details    OOOrderedDictionary.h in OoyalaSDK
 * @par
 * OOOrderedDictionary.addObject:, OOOrderedDictionary.removeObject:, OOOrderedDictionary.removeObjectAtIndex:, OOOrderedDictionary.keysInRange:,
 * OOOrderedDictionary.removeObjectIdenticalTo:, OOOrderedDictionary.sortUsingSelector:, and OOOrderedDictionary.sortWithOptions:usingComparator:
 * require OOOrderedDictionary.keySelector to be set.
 * @date       11/28/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface OOOrderedDictionary : NSObject <NSFastEnumeration> {
@private
  SEL keySelector;
}

@property(nonatomic, assign) SEL keySelector; /**< the selector to use for the key when adding objects using OOOrderedDictionary.addObject: */

/**
 * Initialize a OOOrderedDictionary
 * @param[in] keySelector the selector to use to fetch the key from objects added (using OrderedDicitonary.addObject:)
 * @returns the initialized OOOrderedDictionary
 */
- (id)initWithKeySelector:(SEL)keySelector;

/**
 * Initialize a OOOrderedDictionary
 * @param[in] numItems the initial capacity of the OOOrderedDictionary (not count, just capacity)
 * @returns the initialized OOOrderedDictionary
 */
- (id)initWithCapacity:(NSUInteger)numItems;

/**
 * Initialize a OOOrderedDictionary
 * @param[in] numItems the initial capacity of the OOOrderedDictionary (not count, just capacity)
 * @param[in] keySelector the selector to use to fetch the key from objects added (using OrderedDicitonary.addObject:)
 * @returns the initialized OOOrderedDictionary
 */
- (id)initWithCapacity:(NSUInteger)numItems keySelector:(SEL)keySelector;

/**
 * Add an object to the OOOrderedDictionary
 * @param[in] obj the object to add
 * @param[in] key the key for the object
 */
- (void)setObject:(id)obj forKey:(id)key;

/**
 * Add an object to the OOOrderedDictionary using OOOrderedDictionary.keySelector
 * @param[in] obj the object to add
 */
- (void)addObject:(id)obj;

/**
 * Get the object associated with the key specified
 * @param[in] key the key for the object
 * @returns the object associated with key
 */
- (id)objectForKey:(id)key;

/**
 * Get the index for the object associated with the key specified
 * @param[in] key the key for the object
 * @returns the index for the object associated with key
 */
- (NSInteger)indexForKey:(id)key;

/**
 * Get the index for the object specified
 * @param[in] value the object to get the index for
 * @returns the index for the object
 */
- (NSInteger)indexForValue:(id)value;

/**
 * Get the object at the index specified
 * @param[in] index the index of the object to fetch
 * @returns the object at index
 */
- (id)objectAtIndex:(NSInteger)index;

/**
 * Remove all occurrences in the array of a given object
 * @param[in] obj The object to remove from the array
 */
- (void)removeObject:(id)obj;

/**
 * Removes the object at index
 * @param[in] index The index from which to remove the object in the array. The value must not exceed the bounds of the array.
 */
- (void)removeObjectAtIndex:(NSInteger)index;

/**
 * Removes all occurrences of a given object in the array
 * @param[in] obj The object to remove from the array
 */
- (void)removeObjectIdenticalTo:(id)obj;

/**
 * Sort the array’s elements in ascending order, as determined by the comparison method specified by a given selector
 * @param[in] comparator A selector that specifies the comparison method to use to compare elements in the array
 * @par
 * The comparator message is sent to each object in the array and has as its single argument another object in the array. The comparator method should return NSOrderedAscending if the array is smaller than the argument, NSOrderedDescending if the array is larger than the argument, and NSOrderedSame if they are equal.
 */
- (void)sortUsingSelector:(SEL)comparator;

/**
 * Sort the array using the specified options and the comparison method specified by a given NSComparator Block
 * @param[in] opts A bitmask that specifies the options for the sort (whether it should be performed concurrently and whether it should be performed stably)
 * @param[in] cmptr A comparator block
 */
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;

/**
 * Get the number of objects in the OOOrderedDictionary
 * @returns the number of object in the OOOrderedDictionary
 */
- (NSUInteger)count;

/**
 * Get an ordered array of object in the given range
 * @param[in] range the range of objects to get
 * @returns an NSArray with the objects within the range
 */
- (NSArray *)objectsInRange:(NSRange)range;

/**
 * Get an ordered array of keys in the given range
 * @param[in] range the range of keys to get
 * @returns an NSArray with the keys within the range
 */
- (NSArray *)keysInRange:(NSRange)range;

/** @internal
 * This method is required by the protocol NSFastEnumeration. Simply calls the same from the internal NSMutableArray.
 */
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id *)stackbuf count:(NSUInteger)len;

@end
