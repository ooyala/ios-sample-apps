//
//  ViewController.m
//  ChromecastSampleApp
//
//  Created by Liusha Huang on 9/18/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import "ChromecastListViewController.h"
#import "PlayerViewController.h"
#import "Utils.h"
#import "CustomizedMiniControllerView.h"
#import <OoyalaSDK/OOOoyalaPlayerViewController.h>
#import <OoyalaSDK/OOOoyalaPlayer.h>
#import <OoyalaCastSDK/OOCastMiniControllerView.h>
#import <OoyalaCastSDK/OOCastPlayer.h>
#import <OoyalaCastSDK/OOCastMiniControllerView.h>

@interface ChromecastListViewController ()
@property(nonatomic, strong) IBOutlet UINavigationItem *navigationBar;
@property(nonatomic, strong) NSMutableArray *mediaList;
@property(nonatomic, strong) NSDictionary *currentMediaInfo;
@property(nonatomic, strong) OOCastManager *castManager;

@property (strong, nonatomic) UIBarButtonItem *castButton;
@property (strong, nonatomic) OOCastMiniControllerView *miniControllerView;
@property (strong, nonatomic) OOCastMiniControllerView *bottomMiniControllerView;
@property (strong, nonatomic) NSMutableArray *cells;
@end

@implementation ChromecastListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  //[Utils cleanupLocalFiles];
  self.castManager = [OOCastManager getCastManagerWithAppID:@"4172C76F" namespace:@"urn:x-cast:ooyala"];
  self.castManager.delegate = self;

  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:[self.castManager getCastButton]];
  self.navigationBar.rightBarButtonItem = rightButton;
  [self buildMediaDictionary];
  [self buildTableViewCells];
  
  [self.castManager disconnectFromOoyalaPlayer];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissMiniController) name:OOCastManagerDidDisconnectNotification object:nil];

  [[NSNotificationCenter defaultCenter] addObserverForName:OOCastMiniControllerClickedNotification
                                                    object:nil
                                                     queue:nil
                                                usingBlock:^(NSNotification *note) {
                                                  [self initPlayerViewControllerwithEmbedcode];
                                                }];
}

- (UIViewController *)currentTopUIViewController {
  return [Utils currentTopUIViewController];
}

- (void)dismissMiniController {
  [self.miniControllerView dismiss];
  [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)initPlayerViewControllerwithEmbedcode {
  NSLog(@"Mini Controller click received");
  NSString *embedcode = self.castManager.castPlayer.embedCode;
  if (![self.navigationController.topViewController isKindOfClass:[PlayerViewController class]]) {
    for (NSMutableDictionary *mediaInfo in self.mediaList) {
      if ([[mediaInfo valueForKey:@"embedcode"] isEqualToString:embedcode]) {
        [self dismissMiniController];
        self.currentMediaInfo = mediaInfo;
        [self performSegueWithIdentifier:@"play" sender:self];
      }
    }
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [self dismissMiniController];
}

- (void)viewWillAppear:(BOOL)animated {
  self.castManager.delegate = self;
  if ([self.castManager isInCastMode]) {
    [self displayMiniController];
  }
}

- (void)displayMiniController {
  [self.navigationController setToolbarHidden:NO animated:YES];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initPlayerViewControllerwithEmbedcode)];
  [tap setNumberOfTapsRequired:1];
  [self.navigationController.toolbar addGestureRecognizer:tap];

  self.bottomMiniControllerView = [[OOCastMiniControllerView alloc] initWithFrame:self.navigationController.toolbar.frame castManager:self.castManager];
  [self.castManager.castPlayer registerMiniController:self.bottomMiniControllerView];
  self.bottomMiniControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

  UIBarButtonItem *miniController = [[UIBarButtonItem alloc] initWithCustomView:self.bottomMiniControllerView];

  UIBarButtonItem *negativeSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  negativeSeparator.width = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? -20 : -16;

  NSMutableArray *items = [[NSMutableArray alloc] init];
  [items addObject:negativeSeparator];
  [items addObject:miniController];
  self.toolbarItems = items;
}

- (void)buildTableViewCells {
  if (self.cells == nil) {
    self.cells = [[NSMutableArray alloc] init];
  }
  for (int i = 0; i < self.mediaList.count; i++) {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSDictionary *mediaInfo = [self.mediaList objectAtIndex:i];

    UILabel *mediaTitle = (UILabel *)[cell viewWithTag:1];
    mediaTitle.text = [mediaInfo objectForKey:@"title"];

    UILabel *mediaOwner = (UILabel *)[cell viewWithTag:2];
    mediaOwner.text = @"OOYALA INC.";

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      UIImage *image = [UIImage imageWithData:[Utils getDataFromImageURL:[mediaInfo objectForKey:@"imgurl"]]];
      dispatch_sync(dispatch_get_main_queue(), ^{
        UIImageView *mediaThumb = (UIImageView *)[cell viewWithTag:3];
        [mediaThumb setImage:image];
        [cell setNeedsLayout];
      });
    });
    [self.cells addObject:cell];
  }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.mediaList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [self.cells objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Display the media details view.
  self.currentMediaInfo = [self.mediaList objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:@"play" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [[segue destinationViewController] setMediaInfo:self.currentMediaInfo];
}

- (void)buildMediaDictionary {
  NSMutableDictionary *mediaInfo1 = [[NSMutableDictionary alloc] init];
  [mediaInfo1 setObject:@"wxaWd5bTrJFI--Ga7TgbJtzcPrbzENBV" forKey:@"embedcode"];
  [mediaInfo1 setObject:@"pxY3gwYjrEiFX9bh9_AKCPNbfLH7czoz" forKey:@"pcode"];
  [mediaInfo1 setObject:@"http://www.ooyala.com" forKey:@"domain"];
  [mediaInfo1 setObject:@"CHROMECAST TEST1.mp4" forKey:@"title"];
  [mediaInfo1 setObject:@"http://ak.c.ooyala.com/wxaWd5bTrJFI--Ga7TgbJtzcPrbzENBV/3Gduepif0T1UGY8H4xMDoxOmFkOxyVqc" forKey:@"imgurl"];
  [mediaInfo1 setObject:@"Description" forKey:@"description"];

  NSMutableDictionary *mediaInfo2 = [[NSMutableDictionary alloc] init];
  [mediaInfo2 setObject:@"IzNGg3bzoHHjEfnJP-fj2jB0-oci0Jnm" forKey:@"embedcode"];
  [mediaInfo2 setObject:@"pxY3gwYjrEiFX9bh9_AKCPNbfLH7czoz" forKey:@"pcode"];
  [mediaInfo2 setObject:@"http://www.ooyala.com" forKey:@"domain"];
  [mediaInfo2 setObject:@"DOGMOVIE.mp4" forKey:@"title"];
  [mediaInfo2 setObject:@"http://ak.c.ooyala.com/IzNGg3bzoHHjEfnJP-fj2jB0-oci0Jnm/Ut_HKthATH4eww8X4xMDoxOjBrO-I4W8" forKey:@"imgurl"];
  [mediaInfo2 setObject:@"Description" forKey:@"description"];

  NSMutableDictionary *mediaInfo3 = [[NSMutableDictionary alloc] init];
  [mediaInfo3 setObject:@"xiNmg3bzpFkkwsYqkb5UtGvNOpcwiOCS" forKey:@"embedcode"];
  [mediaInfo3 setObject:@"pxY3gwYjrEiFX9bh9_AKCPNbfLH7czoz" forKey:@"pcode"];
  [mediaInfo3 setObject:@"http://www.ooyala.com" forKey:@"domain"];
  [mediaInfo3 setObject:@"HAPPYFIT2.mp4" forKey:@"title"];
  [mediaInfo3 setObject:@"http://ak.c.ooyala.com/xiNmg3bzpFkkwsYqkb5UtGvNOpcwiOCS/Ut_HKthATH4eww8X4xMDoxOnNpOxmary" forKey:@"imgurl"];
  [mediaInfo3 setObject:@"Description" forKey:@"description"];

  NSMutableDictionary *mediaInfo4 = [[NSMutableDictionary alloc] init];
  [mediaInfo4 setObject:@"Y4OWg3bzoNtSZ9TOg3wl9BPUspXZiMYc" forKey:@"embedcode"];
  [mediaInfo4 setObject:@"pxY3gwYjrEiFX9bh9_AKCPNbfLH7czoz" forKey:@"pcode"];
  [mediaInfo4 setObject:@"http://www.ooyala.com" forKey:@"domain"];
  [mediaInfo4 setObject:@"WEIRDAD.mp4" forKey:@"title"];
  [mediaInfo4 setObject:@"http://ak.c.ooyala.com/Y4OWg3bzoNtSZ9TOg3wl9BPUspXZiMYc/3Gduepif0T1UGY8H4xMDoxOjBmO230Ws" forKey:@"imgurl"];
  [mediaInfo4 setObject:@"Description" forKey:@"description"];

  NSMutableDictionary *mediaInfo5 = [[NSMutableDictionary alloc] init];
  [mediaInfo5 setObject:@"o0OWg3bzrLBNfadaXSaCA7HbknPLFRPP" forKey:@"embedcode"];
  [mediaInfo5 setObject:@"pxY3gwYjrEiFX9bh9_AKCPNbfLH7czoz" forKey:@"pcode"];
  [mediaInfo5 setObject:@"http://www.ooyala.com" forKey:@"domain"];
  [mediaInfo5 setObject:@"HEINZ.mp4" forKey:@"title"];
  [mediaInfo5 setObject:@"http://ak.c.ooyala.com/o0OWg3bzrLBNfadaXSaCA7HbknPLFRPP/3Gduepif0T1UGY8H4xMDoxOjBrO-I4W8" forKey:@"imgurl"];
  [mediaInfo5 setObject:@"Description" forKey:@"description"];
  
  NSMutableDictionary *mediaInfo6 = [[NSMutableDictionary alloc] init];
  [mediaInfo6 setObject:@"0yMjJ2ZDosUnthiqqIM3c8Eb8Ilx5r52" forKey:@"embedcode"];
  [mediaInfo6 setObject:@"c0cTkxOqALQviQIGAHWY5hP0q9gU" forKey:@"pcode"];
  [mediaInfo6 setObject:@"http://www.ooyala.com" forKey:@"domain"];
  [mediaInfo6 setObject:@"Ooyala Player Token" forKey:@"title"];
  [mediaInfo6 setObject:@"http://ak.c.ooyala.com/IzNGg3bzoHHjEfnJP-fj2jB0-oci0Jnm/Ut_HKthATH4eww8X4xMDoxOjBrO-I4W8" forKey:@"imgurl"];
  [mediaInfo6 setObject:@"Description" forKey:@"description"];


  self.mediaList = [[NSMutableArray alloc] init];
  [self.mediaList addObject:mediaInfo1];
  [self.mediaList addObject:mediaInfo2];
  [self.mediaList addObject:mediaInfo3];
  [self.mediaList addObject:mediaInfo4];
  [self.mediaList addObject:mediaInfo5];
  [self.mediaList addObject:mediaInfo6];
}

@end
