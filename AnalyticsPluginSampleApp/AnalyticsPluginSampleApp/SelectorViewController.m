//
//  SelectorViewController.m
//  AnalyticsPluginSampleApp
//
//  Created by Zhihui Chen on 1/12/15.
//  Copyright (c) 2015 ooyala. All rights reserved.
//

#import "SelectorViewController.h"

@interface SelectorViewController ()

@property (nonatomic, retain) NSDictionary *embedCodes;

@end

@implementation SelectorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  if (!_embedCodes) {
    _embedCodes = @{@"ID3-Demo": @"84aDVmcTqN3FrdLXClZgJq-GfFEDhS1a",
                    @"ID3-TravelEast": @"Y5aHlyczqJaJ2Mh6BNWLXfpcmxOaKzcx",
                    @"ID3-TravelLive": @"w3MXlyczp03XOkXoGecg4L8xLIyOiPnR",
                    @"ID3-FoodEast1": @"12YnlyczrWcZvPbIJJTV7TmeVi3tgGPa",
                    @"ID3-FoodEast2": @"B1YXlyczpFZhH6GgBSrrO6VWI6aiMKw0",
                    @"CMS-Demo": @"M3bmM3czp1j9horxoTLGaJtgLmW57u4F",
                    @"CMS-NoAds": @"FzYjJzczo3_M3OjkeIta-IIFcPGSGxci",
                    @"CMS-WithAds": @"x3YjJzczqREV-5RDiemsrdqki1FYu2NT"};
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_embedCodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView
                           dequeueReusableCellWithIdentifier:@"PlayerCell"];
  cell.textLabel.text = [[_embedCodes allKeys] objectAtIndex:indexPath.row];
  return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSIndexPath *index = [self.tableView indexPathForCell:sender];
  NSString *key = [[_embedCodes allKeys] objectAtIndex:index.row];
  _selectedEmbedCode = [_embedCodes objectForKey:key];
}

@end
