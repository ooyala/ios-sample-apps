                                                                                                        //
//  CoreSDKOnlyListViewController.m
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import "CoreSDKOnlyListViewController.h"
#import "PlayerViewController.h"
#import "OptionsDataSource.h"

@interface CoreSDKOnlyListViewController ()

@property (nonatomic) OOCastMiniControllerView *bottomMiniControllerView;

@end

@implementation CoreSDKOnlyListViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"OoyalaSDK assets";
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (self.castManager.isMiniControllerInteractionAvailable) {
    [self displayMiniController];
  } else {
    [self dismissMiniController];
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self dismissMiniController];
}

#pragma mark - Table View

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [super prepareForSegue:segue sender:sender];
  PlayerViewController *controller = segue.destinationViewController;
  ChromecastPlayerSelectionOption *selection = OptionsDataSource.options[self.lastSelected.row];
  controller.mediaInfo = selection;
}

#pragma mark - PlayerViewController

- (void)initPlayerViewControllerWithEmbedcode {
  if (self.lastSelected &&
      ![self.navigationController.topViewController isKindOfClass:PlayerViewController.class]) {
    [self dismissMiniController];
    [self performSegueWithIdentifier:segueName sender:self];
  }
}

#pragma mark - Mini Controller

- (void)displayMiniController {
  [self.navigationController setToolbarHidden:NO animated:YES];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(initPlayerViewControllerWithEmbedcode)];
  [tap setNumberOfTapsRequired:1];
  [self.navigationController.toolbar addGestureRecognizer:tap];
  if (!self.bottomMiniControllerView) {
    _bottomMiniControllerView = [[OOCastMiniControllerView alloc] initWithFrame:self.navigationController.toolbar.frame
                                                                    castManager:self.castManager
                                                                       delegate:self];
  }
  
  [self.castManager registerMiniController:self.bottomMiniControllerView];
  self.bottomMiniControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  
  UIBarButtonItem *miniController = [[UIBarButtonItem alloc] initWithCustomView:self.bottomMiniControllerView];
  UIBarButtonItem *negativeSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                     target:nil
                                                                                     action:nil];
  negativeSeparator.width = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? -20 : -16;
  self.toolbarItems = @[negativeSeparator, miniController];
}

- (void)dismissMiniController {
  [self.navigationController setToolbarHidden:YES animated:YES];
}

#pragma mark - OOCastManagerDelegate

- (void)castManagerDidEnterCastMode:(OOCastManager *)manager {
}

- (void)castManagerDidExitCastMode:(OOCastManager *)manager {
  [super castManagerDidExitCastMode:manager];
  [self dismissMiniController];
}

- (void)castManagerDidDisconnect:(OOCastManager *)manager {
  [super castManagerDidDisconnect:manager];
  [self dismissMiniController];
}

#pragma mark - OOCastMiniControllerDelegate

- (void)miniControllerDidClickOn:(id<OOCastMiniControllerProtocol>)miniControllerView
                   withEmbedCode:(NSString *)embedCode {
  [self initPlayerViewControllerWithEmbedcode];
}

- (void)miniControllerDidDismiss:(id<OOCastMiniControllerProtocol>)miniControllerView {
  [self.navigationController setToolbarHidden:YES animated:YES];
}

@end
