//
//  ContentProtectionListViewController.m
//  ContentProtectionListViewController
//
//  Created by Liusha Huang on 2/23/15.
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "DiscoveryListViewController.h"
#import "PlayerSelectionOption.h"
#import "BasicSimplePlayerViewController.h"
#import <OoyalaSDK/OODiscoveryManager.h>
#import <OoyalaSDK/OODebugMode.h>

@interface DiscoveryListViewController ()

@property NSArray *discoveryResults;

@end

@implementation DiscoveryListViewController

NSString *PCODE = @"c0cTkxOqALQviQIGAHWY5hP0q9gU";
NSString *EMBEDCODE = @"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1";

- (id)init {
  self = [super init];
  self.title = @"Discovery Sample App";
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];

  if (self.discoveryResults == nil) {
    NSMutableArray *momentumResults = [NSMutableArray array];
    NSMutableArray *popularResults = [NSMutableArray array];
    NSMutableArray *similarResults = [NSMutableArray array];
    self.discoveryResults = [NSArray arrayWithObjects:momentumResults, popularResults, similarResults, nil];
  }

  for (NSUInteger type = OODiscoveryTypeMomentum; type <= OODiscoveryTypeSimilarAssets; ++type) {
    OODiscoveryOptions *discoveryOptions = [[OODiscoveryOptions alloc] initWithType:type limit:10 timeout:60];

    [OODiscoveryManager getResults:discoveryOptions embedCode:EMBEDCODE pcode:PCODE parameters:nil callback:^(NSArray *results, OOOoyalaError *error) {
      if (error) {
        LOG(@"discovery request failed, error is %@", error.description);
      } else {
        [self insertDiscoveryResults:results toArray:self.discoveryResults[type]];
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
    PlayerSelectionOption *option = [[PlayerSelectionOption alloc] initWithTitle:name embedCode:embedCode viewController:[BasicSimplePlayerViewController class]];
    [array addObject:option];
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
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
  PlayerSelectionOption *selection = self.discoveryResults[indexPath.section][indexPath.row];
  cell.textLabel.text = [selection title];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  PlayerSelectionOption *selection = self.discoveryResults[indexPath.section][indexPath.row];
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection];
  [self.navigationController pushViewController:controller animated:YES];
}
@end
