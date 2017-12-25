//
//  ListOfVideosViewController.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "ListOfVideosViewController.h"


@interface ListOfVideosViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UISwitch *QAModeSwitch;

@end


@implementation ListOfVideosViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configureNavigationBar];
}

#pragma mark - Private functions

- (void)configureNavigationBar {
  
  // Add QA switch
  
  self.QAModeSwitch = [UISwitch new];
  UILabel *QALabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
  
  QALabel.textAlignment = NSTextAlignmentRight;
  QALabel.text = @"QA";
  
  UIBarButtonItem *QASwitchBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.QAModeSwitch];
  UIBarButtonItem *QALabelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:QALabel];
  
  // Add custom video bar button item
  
  UIBarButtonItem *customVideoBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                            target:self
                                                                                            action:@selector(customVideoBarButtonAction:)];
  
  // Add elements to navigation bar
  
  self.navigationItem.rightBarButtonItems = @[QASwitchBarButtonItem, QALabelBarButtonItem];
  self.navigationItem.leftBarButtonItems = @[customVideoBarButtonItem];
}

- (void)showCustomVideoItemViewController {
  __typeof(self) __weak weakSelf = self;
  
  UIViewController *customVideoViewController = [self.viewModel configuredCustomVideoViewControllerWithCompletion:^(VideoItem *videoItem) {
    [weakSelf openVideoPlayerModuleWithVideoItem:videoItem];
  }];
  
  [self presentViewController:customVideoViewController animated:YES completion:NULL];
}

- (void)openVideoPlayerModuleWithVideoItem:(VideoItem *)videoItem {
  UIViewController *viewController = [self.viewModel configuredVideoViewControllerWithVideoItem:videoItem
                                                                               andQAModeEnabled:self.QAModeSwitch.isOn];
  
  [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Actions

- (void)customVideoBarButtonAction:(id)sender {
  [self showCustomVideoItemViewController];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.viewModel getCountSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.viewModel getCountRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListOfVideosViewControllerTableViewCellID"];
  VideoItem *videoItem = [self.viewModel getVideoItemAt:indexPath];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListOfVideosViewControllerTableViewCellID"];
  }
  
  if (videoItem) {
    cell.textLabel.text = videoItem.title;
  } else {
    cell.textLabel.text = @"Unknow video";
  }
  
  return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  VideoItemSection *videoItemSection = [self.viewModel getVideoItemSectionAtSection:section];
  
  if (videoItemSection) {
    return videoItemSection.title;
  }
  
  return @"Unknow section title";
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  VideoItem *videoItem = [self.viewModel getVideoItemAt:indexPath];
  
  if (videoItem) {
    [self openVideoPlayerModuleWithVideoItem:videoItem];
  }
}


@end
