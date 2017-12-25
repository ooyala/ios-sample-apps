//
// Copyright (c) 2016 Ooyala, Inc. All rights reserved.
//

#define MOVING_AVERAGE_WINDOW_SAMPLE_SIZE 10

/**
 * Keep a running average of the last N samples, where N is MOVING_AVERAGE_WINDOW_SAMPLE_SIZE.
 * \ingroup performance
 */
@interface OOMovingAverage : NSObject <NSCopying>
@property (nonatomic, readonly) double average;
@property (nonatomic, readonly) long long count;
-(void) mergeSample:(double)sample;
@end
