//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

@protocol OOPerformanceStatisticsProtocol <NSCopying>
@property (nonatomic, readonly) NSString *name; /**< Help identify what the statistics came from. */
-(NSString*) generateReport; /**< Mainly for debugging, this could be an expensive operation. */
@end
