//
//  ContentProtectionListViewController.m
//  ContentProtectionListViewController
//
//  Created by Liusha Huang on 2/23/15.
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "DiscoveryListViewController.h"
#import "PlayerSelectionOption.h"
#import "ChannelContentTreeDetailViewController.h"
#import "ChannelContentTreeTableViewCell.h"
#import <OoyalaSDK/OoyalaSDK.h>

@interface DiscoveryListViewController ()

@property NSArray *discoveryResults;
@property NSArray *discoveryOptions;

@end

@implementation DiscoveryListViewController

NSString *PCODE = @"c0cTkxOqALQviQIGAHWY5hP0q9gU";


- (id)init {
  self = [super init];
  self.title = @"Discovery Sample App";
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"ChannelCell" bundle:nil] forCellReuseIdentifier:@"ChannelCell"];

  if (self.discoveryResults == nil) {
    NSMutableArray *momentumResults = [NSMutableArray array];
    NSMutableArray *popularResults = [NSMutableArray array];
    NSMutableArray *similarResults = [NSMutableArray array];
    self.discoveryResults = [NSArray arrayWithObjects:momentumResults, popularResults, similarResults, nil];
  }

  if (self.discoveryOptions == nil) {
    OODiscoveryOptions *momentumOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypeMomentum limit:10 timeout:60];
    OODiscoveryOptions *popularOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular limit:10 timeout:60];
    OODiscoveryOptions *similarOptions = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypeSimilarAssets limit:10 timeout:60];
    self.discoveryOptions = [NSArray arrayWithObjects:momentumOptions, popularOptions, similarOptions, nil];
  }

  for (NSUInteger index = 0; index < self.discoveryOptions.count; ++index) {
    [OODiscoveryManager getResults:self.discoveryOptions[index] embedCode:self.embedCode pcode:PCODE parameters:nil callback:^(NSArray *results, OOOoyalaError *error) {
      if (error) {
        LOG(@"discovery request failed, error is %@", error.description);
      } else {
        [self insertDiscoveryResults:results toArray:self.discoveryResults[index]];
        [self.tableView reloadData];
      }
    }];
  }
}

- (void)insertDiscoveryResults:(NSArray *)results toArray:(NSMutableArray *)array {
  [array removeAllObjects];
  for (NSDictionary *dict in results) {
    NSString *name = [dict objectForKey:@"name" ];
    NSString *embedCode = [dict objectForKey:@"embed_code"];
    NSString *imageUrl = [dict objectForKey:@"preview_image_url"];
    NSNumber *duration = [NSNumber numberWithDouble:[[dict objectForKey:@"duration"] doubleValue] / 1000];
    NSString *bucketInfo = [dict objectForKey:@"bucket_info"];

    LOG(@"receive discovery result name %@, embedCode %@, imageUrl %@, duration %@, bucketInfo %@", name, embedCode, imageUrl, [duration stringValue], bucketInfo);

    [array addObject:dict];
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.discoveryResults.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *results = [self.discoveryResults objectAtIndex:section];
  return results.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *sectionName;
  switch (section)
  {
    case OODiscoveryTypeMomentum:
      sectionName = @"Momentum";
      break;
    case OODiscoveryTypePopular:
      sectionName = @"Popular";
      break;
    case OODiscoveryTypeSimilarAssets:
      sectionName = @"Similar";
      break;
    default:
      sectionName = @"";
      break;
  }
  return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChannelContentTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelCell" forIndexPath:indexPath];
  NSDictionary *dict = self.discoveryResults[indexPath.section][indexPath.row];
  NSString *name = [dict objectForKey:@"name" ];
  NSString *imageUrl = [dict objectForKey:@"preview_image_url"];
  NSNumber *duration = [NSNumber numberWithDouble:[[dict objectForKey:@"duration"] doubleValue] / 1000];
  NSString *bucketInfo = [dict objectForKey:@"bucket_info"];

  if (imageUrl && imageUrl.length > 0) {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
      cell.thumbnail.image = [UIImage imageWithData:data];
    }];
  }
  cell.duration.text = [duration stringValue];
  cell.title.text = name;
  // send impression feedback
  [OODiscoveryManager sendImpression:self.discoveryOptions[indexPath.section] bucketInfo:bucketInfo pcode:PCODE parameters:nil];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *dict = self.discoveryResults[indexPath.section][indexPath.row];
  NSString *name = [dict objectForKey:@"name" ];
  NSString *embedCode = [dict objectForKey:@"embed_code"];
  NSString *bucketInfo = [dict objectForKey:@"bucket_info"];


  PlayerSelectionOption *option = [[PlayerSelectionOption alloc] initWithTitle:name
                                                                     embedCode:embedCode
                                                                         pcode:PCODE
                                                                        domain:@"http://www.ooyala.com"
                                                                viewController:[ChannelContentTreeDetailViewController class]];
  ChannelContentTreeDetailViewController *controller = [[ChannelContentTreeDetailViewController alloc] initWithPlayerSelectionOption:option];
  [self.navigationController pushViewController:controller animated:YES];
  // send click feedback
  // send impression feedback
  [OODiscoveryManager sendClick:self.discoveryOptions[indexPath.section] bucketInfo:bucketInfo pcode:PCODE parameters:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 106.0;
}

@end
