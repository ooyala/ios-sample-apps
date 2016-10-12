//
//  VideoTableViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "VideoTableViewController.h"
#import "AbstractPlayerViewController.h"
#import "FullscreenPlayerViewController.h"
#import "PulseLibraryViewController.h"
#import "FairplayPlayerViewController.h"
#import "PlayerSelectionOption.h"
#import "OoyalaPlayerTokenPlayerViewController.h"

@interface VideoTableViewController ()

@property (nonatomic, strong) NSMutableArray *options; // of Video.h

@end

@implementation VideoTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
    
  [self populateOptions];
}

- (NSMutableArray *)options
{
  if (!_options) {
    _options = [NSMutableArray array];
  }
  return _options;
}

- (void)populateOptions
{
  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Pulse Integration"
                                                             embedCode:nil
                                                                 pcode:nil
                                                                domain:nil
                                                             segueName:@"pulseSegue"]];

  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Fullscreen Player"
                                                             embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                             segueName:@"fullscreenSegue"]];

  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Inline Player"
                                                             embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                             segueName:@"childSegue"]];

  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Player Token (Unconfigured)"
                                                             embedCode:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                             segueName:@"playerTokenSegue"]];

  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Fairplay Baseline Profile (Unconfigured)"
                                                             embedCode:@"V3NDdnMzE6tPCchL9wYTFZY8jAE8_Y21"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                             segueName:@"fairplaySegue"]];
  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Fairplay Main Profile (Unconfigured)"
                                                             embedCode:@"cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                             segueName:@"fairplaySegue"]];
  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Fairplay High Profile (Unconfigured)"
                                                             embedCode:@"d2dzhnMzE6h-LTaIavPD5k2eqLeCTMC5"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                             segueName:@"fairplaySegue"]];
  
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
  
  PlayerSelectionOption *option = self.options[indexPath.row];
  cell.textLabel.text = option.title;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  PlayerSelectionOption *option = self.options[indexPath.row];
  [self performSegueWithIdentifier:option.segueName sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  if ([segue.identifier isEqualToString:@"fullscreenSegue"]) {
    FullscreenPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  } else if ([segue.identifier isEqualToString:@"pulseSegue"]) {
    // no options passed here as the Pulse integration sample has its own content library
  } else if ([segue.identifier isEqualToString:@"childSegue"]){
    AbstractPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  } else if ([segue.identifier isEqualToString:@"playerTokenSegue"]) {
    OoyalaPlayerTokenPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  } else {
    FairplayPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  }
}

@end
