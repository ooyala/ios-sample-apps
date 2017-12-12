/**
 * @class      AdvancedPlaybackListViewController AdvancedPlaybackListViewController.m "AdvancedPlaybackListViewController.m"
 * @brief      A list of playback examples that demonstrate basic playback
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "AdvancedPlaybackListViewController.h"
#import "PlayWithInitialTimePlayerViewController.h"
#import "InsertAdPlayerViewController.h"
#import "PluginPlayerViewController.h"
#import "ChangeVideoPlayerViewController.h"
#import "CustomControlsPlayerViewController.h"
#import "CustomOverlayPlayerViewController.h"
#import "UnbundledPlayerViewController.h"
#import "PerformanceProfilingPlayerViewController.h"
#import "LocalizationLanguagesViewController.h"
#import "NotificationsPlayerViewController.h"
#import "ProgrammaticVolumePlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface AdvancedPlaybackListViewController ()
@property (nonatomic) NSMutableArray *options;
@property (nonatomic) BOOL qaLogEnabled;
@end

@implementation AdvancedPlaybackListViewController

- (id)init {
    self = [super init];
    self.title = @"Advanced Playback";
    return self;
}
- (void)addAllPlayerSelectionOptions {
  // TODO: Check why Plugin Player is failing
//    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Plugin Player"
//                                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
//                                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
//                                                                 domain:@"http://www.ooyala.com"
//                                                         viewController: [PluginPlayerViewController class]]];
    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Change Video Programmatically"
                                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                 domain:@"http://www.ooyala.com"
                                                         viewController: [ChangeVideoPlayerViewController class]]];
    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Insert Ad at Runtime"
                                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                 domain:@"http://www.ooyala.com"
                                                         viewController: [InsertAdPlayerViewController class]]];
    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Play With InitialTime"
                                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                 domain:@"http://www.ooyala.com"
                                                         viewController: [PlayWithInitialTimePlayerViewController class]]];
//    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Custom Controls"
//                                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
//                                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
//                                                                 domain:@"http://www.ooyala.com"
//                                                         viewController: [CustomControlsPlayerViewController class]]];
    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Custom Overlay"
                                                              embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"
                                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                 domain:@"http://www.ooyala.com"
                                                         viewController: [CustomOverlayPlayerViewController class]]];
    [self insertNewObject: [[PlayerSelectionOption alloc] initWithTitle:@"Unbundled HLS"
                                                              embedCode:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
                                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                 domain:@"http://www.ooyala.com"
                                                         viewController: [UnbundledPlayerViewController class]]];
    [self insertNewObject:[[PlayerSelectionOption alloc] initWithTitle:@"Performance Profiling (mid-roll)"
                                                             embedCode:@"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa"
                                                                 pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                                                domain:@"http://www.ooyala.com"
                                                        viewController:[PerformanceProfilingPlayerViewController class]]];
    [self insertNewObject:[[PlayerSelectionOption alloc] initWithTitle:@"Additional localization languages"
                                                             embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                        viewController:[LocalizationLanguagesViewController class]]];
    [self insertNewObject:[[PlayerSelectionOption alloc] initWithTitle:@"Notification Sample"
                                                             embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                        viewController:[NotificationsPlayerViewController class]]];
    [self insertNewObject:[[PlayerSelectionOption alloc] initWithTitle:@"Programmatic Volume"
                                                             embedCode:@"92cWp0ZDpDm4Q8rzHfVK6q9m6OtFP-ww"
                                                                 pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                                domain:@"http://www.ooyala.com"
                                                        viewController:[ProgrammaticVolumePlayerViewController class]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    
    UISwitch *swtLog = [[UISwitch alloc] init];
    [swtLog addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    UILabel *lblLog = [[UILabel alloc]  initWithFrame:CGRectMake(0,0,44,44)];
    [lblLog setText:@"QA"];
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc] initWithCustomView:swtLog];
    UIBarButtonItem * lbl = [[UIBarButtonItem alloc] initWithCustomView:lblLog];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:btn,lbl, nil] ;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil]
         forCellReuseIdentifier:@"TableCell"];
    
    [self addAllPlayerSelectionOptions];
}

- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        self.qaLogEnabled = YES;
    }else{
        self.qaLogEnabled = NO;
    }
}

- (void)insertNewObject:(PlayerSelectionOption *)selectionObject {
    if (!self.options) {
        self.options = [[NSMutableArray alloc] init];
    }
    int index = [self.options count];
    [self.options insertObject:selectionObject atIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    PlayerSelectionOption *selection = self.options[indexPath.row];
    cell.textLabel.text = [selection title];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // When a row is selected, load its desired PlayerViewController
    PlayerSelectionOption *selection = self.options[indexPath.row];
    PlayWithInitialTimePlayerViewController *controller = [(PlayWithInitialTimePlayerViewController *)[[selection viewController] alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaLogEnabled];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
