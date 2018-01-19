//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

/**
 * Minimal stuff an OOPerformanceStatistics object should implement.
 * \ingroup performance
 */
@protocol OOPerformanceStatisticsProtocol <NSCopying>
@property (nonatomic, readonly) NSString *name; /**< Help identify what the statistics came from. */
@property (nonatomic, readonly) long long count; /**< How many times statistics were merged in. */
-(NSString*) generateReport; /**< Mainly for debugging, this could be an expensive operation. */
@end
