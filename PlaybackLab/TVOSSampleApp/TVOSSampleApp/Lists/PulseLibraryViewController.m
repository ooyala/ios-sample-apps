//
//  PulseLibraryViewController.m
//  TVOSSampleApp
//
//  Created by Steve on 2016-10-12.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PulseLibraryViewController.h"
#import "PulsePlayerViewController.h"
#import "PulseLibraryOption.h"

@interface PulseLibraryViewController ()

@property (nonatomic, strong) NSMutableArray *library; // Loaded from library.json

@end

@implementation PulseLibraryViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self populateLibrary];
}

- (NSMutableArray *)library
{
  if (!_library) {
    _library = [NSMutableArray array];
  }
  return _library;
}

- (void)populateLibrary
{
  for (NSDictionary *jsonObject in self.JSONVideoObjects) {
    [self.library addObject:[[PulseLibraryOption alloc] initWithTitle:jsonObject[@"content-title"] embedCode:jsonObject[@"content-code"] category:jsonObject[@"category"] tags:jsonObject[@"tags"] midrollPositions:jsonObject[@"midroll-positions"]]];
  }
  
  [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.library.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
  
  PulseLibraryOption *option = self.library[indexPath.row];
  cell.textLabel.text = option.title;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self performSegueWithIdentifier:@"pulsePlayer" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  PulsePlayerViewController *pulsePlayerViewController = segue.destinationViewController;
  pulsePlayerViewController.option = self.library[indexPath.row];
}

@end
