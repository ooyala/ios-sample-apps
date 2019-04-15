//
//  TableViewController.m
//  Discovery
//
//  Created on 9/1/17.
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic) NSArray *tableData;

@end

@implementation TableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableData = @[@"Articles", @"Browse"];
  
  [self.navigationController setNavigationBarHidden:NO animated:YES]; //Show navigation controller / logo /
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarima"]
                                                forBarMetrics:UIBarMetricsDefault];
  UIImage *img = [UIImage imageNamed:@"logoheader"];
  UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  imgView.image = img;
  imgView.contentMode = UIViewContentModeScaleAspectFit;
  self.navigationItem.titleView = imgView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  if (!cell){
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"Cell"];
  }
  
  cell.textLabel.text = self.tableData[indexPath.row];
  cell.textLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:22.0];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self performSegueWithIdentifier:self.tableData[indexPath.row] sender:self];
}

@end
