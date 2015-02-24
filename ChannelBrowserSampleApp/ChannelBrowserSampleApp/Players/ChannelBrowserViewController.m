//
//  ChannelBrowserViewController.m
//  ChannelBrowserSampleApp
//
//  Created by Zhihui Chen on 2/18/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import "ChannelBrowserViewController.h"
#import "OOOoyalaAPIClient.h"
#import "OOPlayerDomain.h"
#import "OODebugMode.h"
#import "OOOoyalaError.h"
#import "OOChannel.h"
#import "OOVideo.h"
#import "OOOrderedDictionary.h"
#import "ChannelBrowserTableViewCell.h"
#import "ChannelDetailViewController.h"

@interface ChannelBrowserViewController () {
  OOOrderedDictionary *videos;
  OOOoyalaAPIClient *apiClient;
}

@end

@implementation ChannelBrowserViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"ChannelCell" bundle:nil] forCellReuseIdentifier:@"ChannelCell"];
  
  if (apiClient == nil) {
    // Do any additional setup after loading the view.
    NSString *APIKEY = @"R2d3I6s06RyB712DN0_2GsQS-R-Y.nCFrd";
    NSString *SECRETKEY = @"UpmPCeDJspTKqLHO5IyZSRbsSiC7AM_rAqGztDRN";
    NSString *PCODE =@"R2d3I6s06RyB712DN0_2GsQS-R-Y";
    NSString *PLAYER_DOMAIN = @"http://www.ooyala.com";
    OOPlayerDomain *playerDomain = [[OOPlayerDomain alloc] initWithString:PLAYER_DOMAIN];
    apiClient = [[OOOoyalaAPIClient alloc] initWithAPIKey:APIKEY secret:SECRETKEY pcode:PCODE domain:playerDomain];

    if (self.option.embedCode) {
      [apiClient contentTree:[NSArray arrayWithObject:self.option.embedCode] callback:^void(OOContentItem *contentItem, OOOoyalaError *error) {
        if (error) {
          LOG(@"retrieve content tree error %@", error.description);
        } else if ([contentItem isKindOfClass:[OOChannel class]]) {
          OOChannel *channel = (OOChannel *)contentItem;
          videos = channel.videos;
          [self.tableView reloadData];
        }
      }];
    }
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChannelBrowserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelCell" forIndexPath:indexPath];
  OOVideo *video = [videos objectAtIndex:indexPath.row];
  NSString *imageUrl = video.promoImageURL;
  [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    cell.thumbnail.image = [UIImage imageWithData:data];
  }];
  cell.duration.text = [NSString stringWithFormat:@"%f", video.duration];
  cell.title.text = video.title;
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 106.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // When a row is selected, load its desired PlayerViewController
  OOVideo *video = [videos objectAtIndex:indexPath.row];
  PlayerSelectionOption *selection = [[PlayerSelectionOption alloc] initWithTitle:video.title embedCode:video.embedCode viewController:[ChannelDetailViewController class]];
  ChannelDetailViewController *controller = [[ChannelDetailViewController alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
