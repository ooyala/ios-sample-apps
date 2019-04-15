//
//  MainView.m
//  OoyalaSkinSampleApp
//
//  Created on 4/13/17.
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "MainView.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import <OoyalaSDK/OODiscoveryManager.h>

#import "CJSONSerializer.h"
#import "CJSONDeserializer.h"

#import "PlayerSelectionOption.h"
#import "TableViewEmbedCell.h"
#import "PlayerViewController.h"
#import "DemoSettings.h"

@implementation MainView

//layout init configuration
float landscapePercentage = .5f; //% cover player
float portscapePercentage = .4f;
float scrollp = 0.0;
int height = 0;
float padding_margin_Y = 0;
Boolean ignore_init_padding = false; //only used on portrait view/ padding bw /player - scrollview/
float leftPadding = 10;
UIScrollView *scrollView;
Boolean discoveryScreenDisplayed;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(updatetitleDiscovery:)
                                             name:@"NotificationMessageEvent"
                                           object:self.videoTitle];
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(showDiscoveryView:)
                                             name:OOOoyalaPlayerPlayCompletedNotification
                                           object:self.playerViewController];
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(updatetitleDiscovery:)
                                             name:OOOoyalaPlayerPlayStartedNotification
                                           object:self.playerViewController.ooyalaPlayer];
  
  // Init custom class
  self.configuration = [DemoSettings new]; //config object (config.json)
  self.SimilarFeature = -1;
  [self getSimilarFeature];
  
  self.labels = self.configuration.labels;
  self.carousels = [NSMutableArray array];
  
  self.similartableview = [NSMutableArray array];
  self.playerViewController = [PlayerViewController alloc];
  [self UserRender];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [self UserRender];
  if (discoveryScreenDisplayed) {
    //[self loadDiscoveryCarrouselView];
  }
}

- (void)UserRender {
  NSLog(@"User render!");  
  
  if (!UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation)) {
    NSLog(@"orientation! portrait");
    ignore_init_padding = false;
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //Show navigation controller / logo /
    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"navbarima"]  forBarMetrics:UIBarMetricsDefault];
    UIImage *img = [UIImage imageNamed:@"logoheader"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView.image = img;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imgView;
    
    // Title label
    //self.videoTitle = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,55,self.view.frame.size.width,60)];
    self.actualVideoTitle = [(NSDictionary *)self.configuration.initasset objectForKey:@"title"];
    self.videoTitle.text= [@"Article 123: " stringByAppendingString:self.actualVideoTitle];
    self.videoTitle.font= [UIFont fontWithName:@"Roboto-Bold" size:22.0 ];
    self.videoTitle.numberOfLines = 2;
    self.videoTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.videoTitle.textColor = [UIColor colorWithRed:0.29 green:0.31 blue:0.33 alpha:1.0];
    [self.view addSubview:self.videoTitle];
      
    self.videoTitle.hidden = NO;
    
    float playerTop = 150;
    
    height = self.view.frame.size.height * portscapePercentage; //assignt to a variable to know where the player ends
    self.playerview.frame = CGRectMake(leftPadding, playerTop, self.view.frame.size.width * 0.95, height);
    
    NSString *videoDescription = [(NSDictionary *)self.configuration.initasset objectForKey:@"description"];
    
    //Article description label
    //self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 600, self.view.frame.size.width* 0.95, 200)];
    //self.descriptionLabel.text = videoDescription.length > 0 ? videoDescription : @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    self.descriptionLabel.font= [UIFont fontWithName:@"Roboto-Regular" size:20.0];
    //self.descriptionLabel.numberOfLines = 2;
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:self.descriptionLabel];
    self.descriptionLabel.hidden = NO;
   
    if (self.view.frame.size.height < 1000) { //pb exists an elegant way
      padding_margin_Y = self.view.frame.size.height*.15; //iphone`
      scrollp = .4; //iphone scroll padding
    } else {
      padding_margin_Y = self.view.frame.size.height*.10; //ipad portraid
      scrollp = .2; //ipad scroll padding
    }
    
    self.playerViewTop.constant = 80.0;
    self.playerViewHeight.active = YES;
    self.playerViewFullHeight.active = NO;
  } else {
    NSLog(@"orientation! Landscape");
    ignore_init_padding =true;
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //Hide navigationbar
    self.videoTitle.hidden = YES;   //remove title uilabel
    self.descriptionLabel.hidden = YES; //remove description label
    height = self.view.frame.size.height * landscapePercentage; //assignt to a variable to know where the player ends
    self.playerview.frame = CGRectMake(1, 1 , self.view.frame.size.width, height);
    if (self.view.frame.size.height < 768) {
      padding_margin_Y = self.view.frame.size.height*.20; //iphone
      scrollp = .7; //iphone scroll padding
    } else {
      padding_margin_Y = self.view.frame.size.height*.10; //ipad portraid
      scrollp = .25; //ipad scroll padding
    }
    
    scrollView.frame = self.playerview.frame;
    
    self.playerViewTop.constant = 0.0;
    self.playerViewHeight.active = NO;
    self.playerViewFullHeight.active = YES;
  }
  
  if (!ignore_init_padding) {
    height = height + padding_margin_Y;
  }
}

- (void)loadDiscoveryCarrouselView {
  scrollView = [[UIScrollView alloc] initWithFrame:self.playerview.frame];
  //[self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, (self.labels.count * (self.view.frame.size.height*scrollp)))]; //# label * scrollp
  //self.scrollView.frame = CGRectMake(1, height, self.view.frame.size.width, 250);  ////TODO: 512
  CAGradientLayer *gradient = [CAGradientLayer layer];
  gradient.frame = scrollView.bounds;
  gradient.colors = @[(id)UIColor.clearColor.CGColor, (id)UIColor.blackColor.CGColor];
  
  [scrollView.layer insertSublayer:gradient atIndex:0];
  
  int carousel_UI_width = MAX (self.view.frame.size.height,self.view.frame.size.width);
  
  UILabel *labelsection;
  UILabel *sectionImage;
  UIButton *replayButton;
  
  height = 10; //reset height in all devices start on pixel 10
  
  replayButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*.05,180,20,20)];
  [replayButton addTarget:self
                   action:@selector(replayButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
  [replayButton setTitle:@"c" forState:UIControlStateNormal];
  replayButton.titleLabel.textColor = UIColor.whiteColor;
  replayButton.backgroundColor = UIColor.clearColor;
  replayButton.titleLabel.font = [UIFont fontWithName:@"ooyala-slick-type" size:14];
  [scrollView addSubview:replayButton];
  
  sectionImage = labelsection=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*.05,90,self.view.frame.size.width,20)];
  sectionImage.font = [UIFont fontWithName:@"ooyala-slick-type" size:14];
  sectionImage.textColor = UIColor.whiteColor;
  //setting discovery image
  sectionImage.text = @"l";
  [scrollView addSubview:sectionImage];
  
  self.playedVideoName = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*.05 + 40,180,self.view.frame.size.width,20)]; //.05 percentage to right
  self.playedVideoName.text = self.actualVideoTitle;
  self.playedVideoName.font = [UIFont fontWithName:@"Roboto-Bold" size:14.0 ];
  self.playedVideoName.textColor = UIColor.whiteColor;
  self.playedVideoName.backgroundColor = UIColor.clearColor;
  [scrollView addSubview:self.playedVideoName];
  
  //Paint label and table view for each carousel section
  for (int i = 0; i < self.labels.count; i++) {
    //NSLog(@"%@", [self.labels objectAtIndex:i]);
    height = height + 30;
    
    //Create and fill carousel
    UITableView *newtableview;
    newtableview = [self makeTableView:122 valuewidth:carousel_UI_width ycoord:(200*i)+20]; //
    newtableview.backgroundColor = UIColor.clearColor;
    newtableview.delegate = self;   //assign delgate to this class
    newtableview.dataSource = self; //assign datasource to this class
    [self GetDiscoveryData:newtableview
             typeOfhandler:self.configuration.carousels[i][@"handler"]
     carouselConfiguration:self.configuration.carousels[i]];
    
    if (self.configuration.carousels[i][@"realoadOnEmbedcodeChange"]) {
      [self.similartableview addObject:newtableview];
    }
    
    [self.carousels addObject:newtableview];
    //[self.alltableviews addObject:newtableview];
    
    UITableView *carouselLayout = self.carousels[i];
    carouselLayout.frame = CGRectMake(50, height, carouselLayout.frame.size.width, carouselLayout.frame.size.height);
    carouselLayout.backgroundColor = UIColor.clearColor;
    height = height + padding_margin_Y+40;
    
    [scrollView addSubview:carouselLayout];
  }
  
  [self.view addSubview:scrollView];
}

- (void)showDiscoveryView:(NSNotification *)notification {
  //[self loadDiscoveryCarrouselView];
  discoveryScreenDisplayed = true;
}

- (void)replayButtonAction:(id)sender {
  PlayerSelectionOption *value = [[PlayerSelectionOption alloc] initWithTitle:self.videoTitle.text
                                                                    embedCode:self.actualembed
                                                                        pcode:[(NSDictionary *)self.configuration.playerParameters objectForKey:@"pcode"]
                                                                 playerDomain:[(NSDictionary *)self.configuration.playerParameters objectForKey:@"domain"]
                                                               viewController:PlayerViewController.class
                                                                          nib:@"OOplayer"];
  [self.playerViewController initWithPlayerSelectionOption:value];
  
  discoveryScreenDisplayed = false;
  [scrollView removeFromSuperview];
}

- (void)getSimilarFeature {
   //Boolean *result = false;
  for (int i =0; i < self.configuration.carousels.count; i++) {
    if (self.configuration.carousels[i][@"realoadOnEmbedcodeChange"]) {
      self.SimilarFeature = i;
    }
  }
}

- (void)updatetitleDiscovery:(NSNotification *)notification {
  NSDictionary *dict = notification.userInfo;
  NSLog(@":::%@", [dict valueForKey:@"title"]);
  if ([dict valueForKey:@"title"]) {
    // do stuff here with your message data
    self.actualVideoTitle = [dict valueForKey:@"title"];
    self.videoTitle.text = [dict valueForKey:@"title"];
    self.playedVideoName.text= self.actualVideoTitle;
  }
  if (self.playerViewController.ooyalaPlayer.currentItem.title) {
    NSString *title = self.playerViewController.ooyalaPlayer.currentItem.title;
    self.videoTitle.text = title;
    self.playedVideoName.text = title;
    self.actualVideoTitle = title;
  }
}

#pragma mark - UITableView

- (UITableView *)makeTableView:(int)height
                    valuewidth:(int)width
                        ycoord:(int)y_coord {
  CGFloat x = 0;
  CGFloat y = y_coord;
  
  CGRect tableFrame = CGRectMake(x, y, height, width);
  UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame
                                                        style:UITableViewStylePlain];
  tableView.scrollEnabled = YES;
  tableView.showsVerticalScrollIndicator = NO;
  tableView.userInteractionEnabled = YES;
  tableView.bounces = NO;
  CGAffineTransform transform = CGAffineTransformMakeRotation(-1.5707963);
  tableView.transform = transform;
  
  return tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSLog(@":::%lu", (unsigned long)[self.discoveryResults[0] count]);
  return [self.discoveryResults[0] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TableViewEmbedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmbedCell"];  //Create table view with cellidentifier "xib" embedCell
  NSLog(@"discoveryR! %lu", (unsigned long)[self.discoveryResults count]);
  
  cell.thumbnail.image = nil;
  if ([self.discoveryResults[0] count] > 1) {
    NSDictionary *dict = self.discoveryResults[0][indexPath.row];
    NSString *name = [self decodeString:dict[@"name"]];
    NSString *imageUrl = dict[@"preview_image_url"];
    NSNumber *duration = @([dict[@"duration"] doubleValue] / 1000);
    if (imageUrl && imageUrl.length > 0) {
      [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]]
                                         queue:[NSOperationQueue mainQueue]
                             completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         cell.thumbnail.image = [UIImage imageWithData:data];
      }];
    }
    cell.duration = duration.stringValue;
    cell.title = name;
    cell.embedcode = dict[@"embed_code"];
    cell.backgroundColor = UIColor.clearColor;
    cell.titleLabel.text = name;
  }
  
  if (!cell) {
    //Assign your view controller class to File Owner of your custom cell EmbedCell.xib
    NSArray *nib = [NSBundle.mainBundle loadNibNamed:@"EmbedCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
  }
  
  return cell;
}

- (NSString *)decodeString:(NSString *)data {
  NSData *stringData = [data dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
  NSAttributedString *decodedAttributedString = [[NSAttributedString alloc] initWithData:stringData
                                                                                 options:options
                                                                      documentAttributes:NULL
                                                                                   error:NULL];
  return decodedAttributedString.string;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
  //Rotate cell
  CGAffineTransform transform = CGAffineTransformMakeRotation(1.5707963);
  cell.transform = transform;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  NSString *embedCode = [(TableViewEmbedCell *)cell embedcode];
  self.actualembed = embedCode;
  self.videoTitle.text = [(TableViewEmbedCell *)cell title];
  self.playedVideoName.text= [(TableViewEmbedCell *)cell title];
  PlayerSelectionOption *value = [[PlayerSelectionOption alloc] initWithTitle:self.videoTitle.text
                                                                    embedCode:self.actualembed
                                                                        pcode:[(NSDictionary *)self.configuration.playerParameters objectForKey:@"pcode"]
                                                                 playerDomain:[(NSDictionary *)self.configuration.playerParameters objectForKey:@"domain"]
                                                               viewController:[PlayerViewController class]
                                                                          nib:@"OOplayer"];
  PlayerViewController *c = [[PlayerViewController alloc] initWithPlayerSelectionOption:value];
  
  if ((int)self.SimilarFeature >= 0){
    [self GetDiscoveryData:self.similartableview[0]
             typeOfhandler:self.configuration.carousels[self.SimilarFeature][@"handler"]
     carouselConfiguration:self.configuration.carousels[self.SimilarFeature]];
  }
  //Removing discovery carrousel view
  [scrollView removeFromSuperview];

  discoveryScreenDisplayed = false;
}

- (void)GetDiscoveryData:(UITableView*)actual_carousel
           typeOfhandler:handler
   carouselConfiguration:carouselConfig {
  [actual_carousel registerNib:[UINib nibWithNibName:@"EmbedCell" bundle:nil] forCellReuseIdentifier:@"EmbedCell"];
  
  if (!self.actualembed) {
    self.actualembed = [(NSDictionary *)self.configuration.initasset objectForKey:@"embedCode"];
  }

  if ([handler isEqual:@"middleware"]) {
    NSMutableArray *middlewareResults = [NSMutableArray array];
    self.discoveryResults = @[middlewareResults];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    
    NSString *urlForHttpGet = carouselConfig[@"url"];
    
    if ([urlForHttpGet rangeOfString:@"[embedcode]"].location != NSNotFound) {
      urlForHttpGet = [urlForHttpGet stringByReplacingOccurrencesOfString:@"[embedcode]" withString:self.actualembed];
    }
    
    request.URL = [NSURL URLWithString:urlForHttpGet];
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
      NSLog(@"requestReply: %@", requestReply);
      NSData* datable = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
      NSError *theError = NULL;
      CJSONDeserializer *theDeserializer = [CJSONDeserializer deserializer];
      id Result = [theDeserializer deserialize:datable error:&theError];
      NSLog(@"results::: %@", Result);
      NSArray *assets = [Result objectForKey:[carouselConfig objectForKey:@"jsonRoot"]];
      NSLog(@"results: %@", assets);
      
      [self insertDiscoveryResults:assets toArray:self.discoveryResults[0]];
      
      dispatch_sync(dispatch_get_main_queue(), ^{
        CGPoint contentOffset = CGPointZero;
        contentOffset.y = 500;//actual_carousel.contentSize.height - actual_carousel.frame.size.height;
        contentOffset.x = 0;
        [actual_carousel reloadData];
        [actual_carousel layoutIfNeeded];
        
        [UIView animateWithDuration:2.0 animations:^{
          [actual_carousel setContentOffset:contentOffset];
        }];
        contentOffset.y = 0;  contentOffset.x = 0;
        [UIView animateWithDuration:2.0 animations:^{
          [actual_carousel setContentOffset:contentOffset];
        }];
        
      });
      
    }] resume];
    
  } else { //DiscoveryApi
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
    for (NSUInteger index = 0; index < discoveryOptions.count; ++index) {
      [OODiscoveryManager getResults:discoveryOptions[index]
                           embedCode:self.actualembed
                               pcode:[(NSDictionary *)self.configuration.playerParameters objectForKey:@"pcode"]
                          parameters:nil
                            callback:^(NSArray *results, OOOoyalaError *error) {
        if (error) {
          NSLog(@"discovery request failed, error is %@", error.description);
        } else {
          [self insertDiscoveryResults:results toArray:self.discoveryResults[0]];
          [actual_carousel reloadData];

          CGPoint contentOffset = CGPointZero;
          contentOffset.y = 500;//actual_carousel.contentSize.height - actual_carousel.frame.size.height;
          contentOffset.x = 0;
          [actual_carousel reloadData];
          [actual_carousel layoutIfNeeded];

          [UIView animateWithDuration:2.0 animations:^{
            [actual_carousel setContentOffset:contentOffset];
          }];
          contentOffset.y = 0;  contentOffset.x = 0;
          [UIView animateWithDuration:2.0 animations:^{
          [actual_carousel setContentOffset:contentOffset];
          }];
        }
      }];
    }
  }
}

- (void)insertDiscoveryResults:(NSArray *)results toArray:(NSMutableArray *)array {
  [array removeAllObjects];
  for (NSDictionary *dict in results) {
    //Decoding HTML data
    NSData* stringData = [dict[@"name"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    NSAttributedString* decodedAttributedString = [[NSAttributedString alloc] initWithData:stringData
                                                                                   options:options
                                                                        documentAttributes:NULL
                                                                                     error:NULL];
    NSString *name = [decodedAttributedString string];
    NSString *embedCode = dict[@"embed_code"];
    NSString *imageUrl = dict[@"preview_image_url"];
    NSNumber *duration = @([dict[@"duration"] doubleValue] / 1000);
    NSString *bucketInfo = dict[@"bucket_info"];
    NSString *description = dict[@"description"];
    NSLog(@"receive discovery result name %@, embedCode %@, imageUrl %@, duration %@, bucketInfo %@, description %@", name, embedCode, imageUrl, [duration stringValue], bucketInfo, description);
    [array addObject:dict];
  }
}

@end
