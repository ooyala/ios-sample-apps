//
//  ListOfVideosViewModel.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

@import UIKit;
@class VideoItemSection;
@class VideoItem;

@interface ListOfVideosViewModel : NSObject

- (NSInteger)getCountSections;
- (NSInteger)getCountRowsInSection:(NSInteger)section;
- (VideoItemSection *)getVideoItemSectionAtSection:(NSInteger)section;
- (VideoItem *)getVideoItemAt:(NSIndexPath *)indexPath;
- (UIViewController *)configuredCustomVideoViewControllerWithCompletion:(void (^)(VideoItem *videoItem))completion;
- (UIViewController *)configuredVideoViewControllerWithVideoItem:(VideoItem *)videoItem andQAModeEnabled:(BOOL)QAModeEnabled;

@end
