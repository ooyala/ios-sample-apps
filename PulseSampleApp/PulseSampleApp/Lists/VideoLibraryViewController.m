//
//  VideoLibraryViewController.m
//  PulsePlayer
//
//  Created by Jacques du Toit on 13/10/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Pulse/Pulse.h>

#import "VideoLibraryViewController.h"
#import "VideoItemCell.h"

#import "PulseManagerViewController.h"

#define VIDEO_CELL_REUSE_ID @"VideoItemCell"

@interface VideoLibraryViewController ()

// Our video library is just an array of VideoItem objects
@property (strong, nonatomic) NSArray<VideoItem *> *videos;

@end

@implementation VideoLibraryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"VideoItemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VIDEO_CELL_REUSE_ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Start playing the video item at specified index
- (void)playVideo:(NSInteger)index
{
  VideoItem *videoItem = self.videos[index];
  UIViewController *vc = [[PulseManagerViewController alloc] initWithVideoItem:videoItem];
  
  [self.navigationController pushViewController:vc animated:YES];
  
}

#pragma mark - Video libray

// Load video library from library.json into a JSON array.
- (NSArray *)JSONVideoObjects
{
  NSError *jsonError;
  NSString* path  = [[NSBundle mainBundle] pathForResource:@"library" ofType:@"json"];
  NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:path]
                                                         options:0
                                                           error:&jsonError];
  assert(jsonError == nil);
  return jsonObjects;
}

- (NSArray<VideoItem*> *)videos
{
  if (!_videos) {
    // Parse and add each video in the JSON array to our video library
    NSMutableArray *videos = [NSMutableArray array];
    for (NSDictionary *jsonObject in self.JSONVideoObjects) {
      [videos addObject:[VideoItem videoItemWithDictionary:jsonObject]];
    }
    _videos = videos;
  }
  return _videos;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return section == 0 ? self.videos.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  VideoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:VIDEO_CELL_REUSE_ID forIndexPath:indexPath];
  
  [cell setVideoItem:self.videos[indexPath.row]];
    
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // The rows are slightly taller in the TVOS sample.
#if TARGET_OS_TV
  return 88;
#else
  return 60;
#endif
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self playVideo:indexPath.row];
}



@end
