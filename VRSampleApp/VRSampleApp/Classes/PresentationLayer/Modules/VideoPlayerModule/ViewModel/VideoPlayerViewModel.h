//
//  VideoPlayerViewModel.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoItem.h"


@interface VideoPlayerViewModel : NSObject

@property (nonatomic) VideoItem *videoItem;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *domain;
@property (nonatomic) BOOL QAModeEnabled;

- (instancetype)initWithVideoItem:(VideoItem *)videoItem
                            pcode:(NSString *)pcode
                           domain:(NSString *)domain
                 andQAModeEnabled:(BOOL)QAModeEnabled;

@end
