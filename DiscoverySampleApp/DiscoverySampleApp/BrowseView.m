//
//  BrowseView.m
//  Discovery
//
//  Created on 9/4/17.
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "BrowseView.h"
#import "BrowseButton.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSDK/OODiscoveryManager.h>
#import "PlayerSelectionOption.h"
#import "DemoSettings.h"
#import "PlayerViewController.h"
#import "NetworkManager.h"

@interface BrowseView () <PlayerViewControllerDelegate>

@property (nonatomic) IBOutlet UILabel *videoTitle;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewHeight;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewFullHeight;

@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewTop;
@property (nonatomic) IBOutlet NSLayoutConstraint *scrollViewTop;
@property (nonatomic) IBOutlet UIView *playerview;
@property (nonatomic) IBOutlet UIScrollView *scrollview;

@property (nonatomic) DemoSettings *configuration; //read config.json
@property (nonatomic) NSArray *labels; //user labels
@property (nonatomic) NSArray *discoveryResults; //results of middleware/discoveryapi
@property (nonatomic) NSString *actualembed; //embed
@property (nonatomic) int SimilarFeature;
@property (nonatomic) PlayerViewController *playerViewController;
@property (nonatomic) NetworkManager *networkManger;

@end

@implementation BrowseView

static float const percentage = .5f; //% cover player

#pragma mark - Init

- (void)viewDidLoad {
  [super viewDidLoad];

  _networkManger = [NetworkManager new];

  // Init custom class
  self.configuration = [DemoSettings new]; //config object (config.json)
  self.SimilarFeature = -1;
  [self getSimilarFeature];
  
  self.labels = self.configuration.labels;
  [self getDiscoveryForCarouselConfiguration:self.configuration.carousels[0]];

  [self setupUI];
  [self renderPortrait];
}

- (void)setupUI {
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarima"]
                                                forBarMetrics:UIBarMetricsDefault];
  UIImage *img = [UIImage imageNamed:@"logoheader"];
  UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  imgView.image = img;
  imgView.contentMode = UIViewContentModeScaleAspectFit;
  self.navigationItem.titleView = imgView;

  // Title label
  self.videoTitle.text = self.configuration.initasset[@"title"];
  self.videoTitle.textColor = [UIColor colorWithRed:0.29 green:0.31 blue:0.33 alpha:1.0];
}

- (void)clearScrollView {
  dispatch_async(dispatch_get_main_queue(), ^{
    for (UIView *subview in self.scrollview.subviews) {
      [subview removeFromSuperview];
    }
  });
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
    switch (orientation) {
      case UIDeviceOrientationPortrait:
      case UIDeviceOrientationPortraitUpsideDown:
        [self renderPortrait];
        break;

      default:
        [self renderLandscape];
        break;
    }
  } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
  }];

  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)renderPortrait {
  NSLog(@"User render orientation: portrait");
//  [self clearScrollView];

  //layout init configuration
  float scrollp = self.view.frame.size.height < 1000 ? .4 : .2;
  int height = self.view.frame.size.height * percentage; //assignt to a variable to know where the player ends
  float padding_margin_Y = self.view.frame.size.height *
                          (self.view.frame.size.height < 1000 ? .15 : .1);

  [self.navigationController setNavigationBarHidden:NO animated:YES]; //Show navigation controller / logo /
  self.videoTitle.hidden = NO;

  self.playerview.frame = CGRectMake(1, 87, self.view.frame.size.width, height);
  self.playerViewTop.constant = 80.0;
  self.playerViewHeight.active = YES;
  self.playerViewFullHeight.active = NO;
  self.scrollViewTop.active = YES;

  height += padding_margin_Y;

  self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width,
                                           (self.labels.count * (self.view.frame.size.height * scrollp))); //# label * scrollp
  self.scrollview.frame = CGRectMake(1, height, self.view.frame.size.width, 512);  ////TODO: 512
}

- (void)renderLandscape {
  NSLog(@"User render orientation: landscape");
//  [self clearScrollView];

  //layout init configuration
  float scrollp = self.view.frame.size.height < 768 ? .7 : .25;// iphone : ipad
  int height    = self.view.frame.size.height * percentage;//assignt to a variable to know where the player ends

  [self.navigationController setNavigationBarHidden:YES animated:YES]; //Hide navigationbar
  self.videoTitle.hidden = YES;   //remove title uilabel

  self.playerview.frame = CGRectMake(1, 1, self.view.frame.size.width, height);
  self.playerViewTop.constant = 0.0;
  self.playerViewHeight.active = NO;
  self.playerViewFullHeight.active = YES;
  self.scrollViewTop.active = NO;

  self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width,
                                           self.labels.count * (self.view.frame.size.height * scrollp)); //# label * scrollp
  self.scrollview.frame = CGRectMake(1, height, self.view.frame.size.width, 512);  ////TODO: 512
}

#pragma mark - PlayerViewDelegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"embed"]) {
    self.playerViewController = segue.destinationViewController;
    self.playerViewController.delegate = self;
  }
}

- (void)didUpdateAssetTitle:(NSString *)title {
  dispatch_async(dispatch_get_main_queue(), ^{
    self.videoTitle.text = title;
  });
}

- (void)didStartPlaying {
//  [self updateScrollViewWithDiscovery];
}

#pragma mark - discovery

- (void)getSimilarFeature {
  // Boolean *result = false;
  for (int i = 0; i < self.labels.count; i++) {
    if (self.configuration.carousels[i][@"realoadOnEmbedcodeChange"]) {
      self.SimilarFeature = i;
    }
  }
}

- (void)getDiscovery {
  for (NSDictionary *carouselConfig in self.configuration.carousels) {
    //Create and fill carousel
    [self getDiscoveryForCarouselConfiguration:carouselConfig];
  }
}

- (void)updateScrollViewWithDiscovery {
  dispatch_async(dispatch_get_main_queue(), ^{
    for (UIView *subview in self.scrollview.subviews) {
      [subview removeFromSuperview];
    }
  
    NSInteger resultsCount = [self.discoveryResults[0] count];
    float videoWidth       = self.view.frame.size.width * 0.45;
    float horizontalMargin = (self.view.frame.size.width * 0.1) / 3;

    if (resultsCount > 1) {
      int xValue = 0;
      int yValue = 0;

      for (NSDictionary *discoverуResult in self.discoveryResults[0]) {
        BrowseButton *button = [[BrowseButton alloc] initWithFrame:CGRectMake(horizontalMargin + xValue,
                                                                              120 * yValue,
                                                                              videoWidth,
                                                                              110)];
        NSString *name = discoverуResult[@"name"];
        NSString *imageUrl = discoverуResult[@"preview_image_url"];
        if (imageUrl && imageUrl.length > 0) {
          NSURL *url = [NSURL URLWithString:imageUrl];
          NSData *data = [NSData dataWithContentsOfURL:url];
          UIImage *image = [UIImage imageWithData:data];
          [button setBackgroundImage:image forState:UIControlStateNormal];
        }

        button.embedCode = discoverуResult[@"embed_code"];
        button.titleLabel.text = name;
        button.title = name;
        
        if (name) {
          [self.scrollview addSubview:button];
          [button addTarget:self
                     action:@selector(onVideoSelected:)
           forControlEvents:UIControlEventTouchUpInside];
          yValue++;
          if (yValue == resultsCount / 2) {
            xValue = videoWidth + horizontalMargin;
            yValue = 0;
          }
        }
      }
    }
  });
}

- (IBAction)onVideoSelected:(BrowseButton *)sender {
  NSString *embedCode = sender.embedCode;
  self.actualembed = embedCode;
  
  self.videoTitle.text = sender.title;
  PlayerSelectionOption *value = [[PlayerSelectionOption alloc] initWithTitle:self.videoTitle.text
                                                                    embedCode:self.actualembed
                                                                        pcode:self.configuration.playerParameters[@"pcode"]
                                                                 playerDomain:self.configuration.playerParameters[@"domain"]
                                                               viewController:PlayerViewController.class
                                                                          nib:@"OOplayer"];
  self.playerViewController = [self.playerViewController initWithPlayerSelectionOption:value];
  self.playerViewController.delegate = self;
  
  if (self.SimilarFeature >= 0) {
    [self getDiscoveryForCarouselConfiguration:self.configuration.carousels[self.SimilarFeature]];
  }
}

- (void)getDiscoveryForCarouselConfiguration:(NSDictionary *)carouselConfig {
  if (!self.actualembed) {
    self.actualembed = self.configuration.initasset[@"embedCode"];
  }

  NSString *handler = carouselConfig[@"handler"];
  if ([handler isEqual:@"middleware"]) {
    NSMutableArray *middlewareResults = [NSMutableArray array];
    self.discoveryResults = @[middlewareResults];
    return [self.networkManger getMiddlewareDataForEmbedCode:self.actualembed
                                           andCarouselConfig:carouselConfig
                                              withCompletion:^(NSArray *assets) {
       if (assets) {
         [self insertDiscoveryResults:assets toArray:self.discoveryResults[0]];
         [self updateScrollViewWithDiscovery];
       }
    }];
  }
  //DiscoveryApi
  OODiscoveryOptions *discoveryOption;
  if ([carouselConfig[@"type"] isEqualToString:@"Momentum"]) {
    discoveryOption = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypeMomentum
                                                         limit:10
                                                       timeout:60];
  } else if ([carouselConfig[@"type"] isEqualToString:@"Similar"]) {
    discoveryOption = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular
                                                         limit:10
                                                       timeout:60];
  } else if ([carouselConfig[@"type"] isEqualToString:@"Popular"]) {
    discoveryOption = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypeSimilarAssets
                                                         limit:10
                                                       timeout:60];
  }
  NSArray *discoveryOptions = @[discoveryOption];
  for (OODiscoveryOptions *discoveryOption in discoveryOptions) {
    [OODiscoveryManager getResults:discoveryOption
                         embedCode:self.actualembed
                             pcode:self.configuration.playerParameters[@"pcode"]
                        parameters:nil
                          callback:^(NSArray *results, OOOoyalaError *error) {
      if (error) {
        NSLog(@"discovery request failed, error is %@", error.description);
      } else {
        [self insertDiscoveryResults:results toArray:self.discoveryResults[0]];
        dispatch_async(dispatch_get_main_queue(), ^{
          [self updateScrollViewWithDiscovery];
        });
      }
    }];
  }
}

- (void)insertDiscoveryResults:(NSArray *)results toArray:(NSMutableArray *)array {
  [array removeAllObjects];
  for (NSDictionary *dict in results) {
    NSString *name = dict[@"name" ];
    NSString *embedCode = dict[@"embed_code"];
    NSString *imageUrl = dict[@"preview_image_url"];
    NSNumber *duration = @([dict[@"duration"] doubleValue] / 1000);
    NSString *bucketInfo = dict[@"bucket_info"];
    NSLog(@"receive discovery result name %@, embedCode %@, imageUrl %@, duration %@, bucketInfo %@", name, embedCode, imageUrl, [duration stringValue], bucketInfo);
    [array addObject:dict];
  }
}

@end
