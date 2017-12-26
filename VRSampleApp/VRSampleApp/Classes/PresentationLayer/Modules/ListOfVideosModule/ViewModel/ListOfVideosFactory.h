//
//  ListOfVideosFactory.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoItem.h"


@interface ListOfVideosFactory : NSObject

- (UIViewController *)viewControllerWithVideoItem:(VideoItem *)videoItem
                                            pcode:(NSString *)pcode
                                           domain:(NSString *)domain
                                    QAModeEnabled:(BOOL)QAModeEnabled;

- (UIViewController *)configuredCustomVideoViewControllerWithCompletion:(void (^)(NSString *pCode, NSString *embedCode))completion;

@end
