//
//  TableViewController.m
//  Discovery
//
//  Created by Ileana Padilla on 9/1/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewController.h"

@implementation TableViewController

  NSArray *tableData;
  
-(void)viewDidLoad {
  
  [super viewDidLoad];
  
  tableData = [NSArray arrayWithObjects:@"Articles", @"Browse", nil];
  
  [self.navigationController setNavigationBarHidden:NO animated:YES]; //Show navigation controller / logo /
  [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"navbarima"]  forBarMetrics:UIBarMetricsDefault];
  UIImage *img = [UIImage imageNamed:@"logoheader"];
  UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  [imgView setImage:img];
  [imgView setContentMode:UIViewContentModeScaleAspectFit];
  self.navigationItem.titleView = imgView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  if (cell == nil){
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  }
  
  cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
  cell.textLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:22.0 ];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [ self performSegueWithIdentifier:[tableData objectAtIndex:indexPath.row] sender:self];
}

@end
