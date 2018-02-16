//
//  BrowseView.m
//  Discovery
//
//  Created by Ileana Padilla on 9/4/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrowseView.h"
#import "BrowseButton.h"

@implementation BrowseView

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(updatetitleDiscovery:) name:@"NotificationMessageEvent" object:self.videoTitle];
  [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(browseDiscovery:) name:OOOoyalaPlayerPlayStartedNotification object:self.playerViewController.ooyalaPlayer];
  
  // Init custom class
  self.configuration = [[DemoSettings alloc] initReadJSONFile]; //config object (config.json)
  self.SimilarFeature = -1;
  self.getSimilarFeature;
  
  self.labels = (NSArray *)[self.configuration getLabels:self.configuration.carousels];
  self.playerViewController = [PlayerViewController alloc];
  
  self.UserRender;
  
}


- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  self.UserRender;
}

- (void) UserRender{
  NSLog(@"User render!");
  
  //layout init configuration
  float percentage = .5f; //% cover player
  float scrollp = 0.0;
  int height = 0;
  float padding_margin_Y = 0;
  Boolean ignore_init_padding = false; //only used on portrait view/ padding bw /player - scrollview/
  
  //Portrait / landscape clean
  for (UIView *subview in self.scrollview.subviews) {
    [subview removeFromSuperview];
  }
  
  
  if (!UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
    NSLog(@"orientation! portrait");
    ignore_init_padding = false;
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //Show navigation controller / logo /
    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"navbarima"]  forBarMetrics:UIBarMetricsDefault];
    UIImage *img = [UIImage imageNamed:@"logoheader"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    
    // Title label
    self.videoTitle.text= [self decodeString:[(NSDictionary *)self.configuration.initasset objectForKey:@"title"]];
    self.videoTitle.font=[UIFont fontWithName:@"Roboto-Bold" size:22.0 ];
    self.videoTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.videoTitle.numberOfLines = 2;
    self.videoTitle.adjustsFontSizeToFitWidth = NO;
    self.videoTitle.textColor = [UIColor colorWithRed:0.29 green:0.31 blue:0.33 alpha:1.0];
    [self.view addSubview:self.videoTitle];
    
    
    height = self.view.frame.size.height * percentage; //assignt to a variable to know where the player ends
    self.playerview.frame = CGRectMake(1, 87, self.view.frame.size.width, height);
    
    if(self.view.frame.size.height < 1000){ //pb exists an elegant way
      padding_margin_Y = self.view.frame.size.height*.15; //iphone
      scrollp = .4; //iphone scroll padding
    }else{
      padding_margin_Y = self.view.frame.size.height*.10; //ipad portraid
      scrollp = .2; //ipad scroll padding
    }
    
    self.playerViewTop.constant = 80.0;
    self.playerViewHeight.active = YES;
    self.playerViewFullHeight.active = NO;
    self.scrollViewTop.active = YES;
    
    [self browseDiscovery:nil];
  }
  
  else {
    NSLog(@"orientation! Landscape");
    ignore_init_padding =true;
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //Hide navigationbar
    [self.videoTitle removeFromSuperview];   //remove title uilabel
    height = self.view.frame.size.height * percentage; //assignt to a variable to know where the player ends
    self.playerview.frame = CGRectMake(1, 1 , self.view.frame.size.width, height);
    if(self.view.frame.size.height < 768){
      padding_margin_Y = self.view.frame.size.height*.20; //iphone
      scrollp = .7; //iphone scroll padding
    }else{
      padding_margin_Y = self.view.frame.size.height*.10; //ipad portraid
      scrollp = .25; //ipad scroll padding
    }
    
    self.playerViewTop.constant = 0.0;
    self.playerViewHeight.active = NO;
    self.playerViewFullHeight.active = YES;
    self.scrollViewTop.active = NO;
  }
  
  
  if(!ignore_init_padding){ height = height + padding_margin_Y; }
  
  [self.scrollview setContentSize:CGSizeMake(self.view.frame.size.width, (self.labels.count * (self.view.frame.size.height*scrollp)))]; //# label * scrollp
  self.scrollview.frame = CGRectMake(1, height, self.view.frame.size.width, 512);  ////TODO: 512
  
  int carousel_UI_width = MAX (self.view.frame.size.height,self.view.frame.size.width);
  
  UILabel *labelsection;
  height = 0; //reset height in all devices start on pixel 20
  

  for (int i = 0; i < [self.labels count]; i++)
  {
    //Create and fill carousel
    UITableView *newtableview;
    [self GetDiscoveryData:newtableview typeOfhandler:[self.configuration.carousels[i] objectForKey:@"handler"] carouselConfiguration:self.configuration.carousels[i]];
  }
  
}
- (void) getSimilarFeature
{
  //Boolean *result = false;
  for (int i =0; i < self.configuration.carousels.count; i++) {
    if([self.configuration.carousels[i] objectForKey:@"realoadOnEmbedcodeChange"]){
      self.SimilarFeature = i;
    }
  }
  
}

-(void) updatetitleDiscovery:(NSNotification *) notification
{
  NSDictionary *dict = notification.userInfo;
  NSLog(@":::%@", [dict valueForKey:@"title"]);
  if ([dict valueForKey:@"title"] != nil) {
    // do stuff here with your message data
    self.videoTitle.text = [dict valueForKey:@"title"];
  }
}

- (void)browseDiscovery:(NSNotification *) notification{
  //Removing existent views from scrollview
  for (UIView* v in self.scrollview.subviews){
    [v removeFromSuperview];
  }
  
  int resultsCount = [self.discoveryResults[0] count];
  float videoWidth = self.view.frame.size.width * 0.45;
  float horizontalMargin = (self.view.frame.size.width * 0.1)/3;
  float videoHeight = self.view.frame.size.height;
  
  if(resultsCount > 1){
    int xValue = 0;
    int yValue = 0;
    for (int i = 0; i < [self.discoveryResults[0] count]; i++){
        BrowseButton *button = [[BrowseButton alloc] initWithFrame:CGRectMake(horizontalMargin+xValue, (120*yValue), videoWidth, 110)];
        NSDictionary *dict = self.discoveryResults[0][i];
        NSString *name = [dict objectForKey:@"name"];
        NSString *imageUrl = [dict objectForKey:@"preview_image_url"];
        NSString *duration = [NSNumber numberWithDouble:[[dict objectForKey:@"duration"] doubleValue] /1000];
        if (imageUrl && imageUrl.length > 0) {
          [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
              [button setBackgroundImage: [UIImage imageWithData:data] forState:(UIControlStateNormal)];
            
          }];
        }
      button.embedCode = [dict objectForKey:@"embed_code"];
      button.titleLabel.text = [self decodeString:name];
      button.title = [self decodeString:name];
      button.backgroundColor = [UIColor blackColor];
      if(name != nil){
        [self.scrollview addSubview:button];
        [button addTarget:self action:@selector(onVideoSelected:) forControlEvents:UIControlEventTouchUpInside];
        yValue++;
        if (yValue == (resultsCount)/2){
          xValue = videoWidth + (horizontalMargin);
          yValue = 0;
        }
      }
    }
    
  }
}

- (IBAction)onVideoSelected:(BrowseButton*)sender{
  NSString *embedCode = sender.embedCode;
  self.actualembed = embedCode;
  
  self.videoTitle.text = sender.title;
  PlayerSelectionOption *value = [[PlayerSelectionOption alloc] initWithTitle:self.videoTitle.text embedCode:self.actualembed pcode:[(NSDictionary *)self.configuration.playerParameters objectForKey:@"pcode"]  playerDomain:[(NSDictionary *)self.configuration.playerParameters objectForKey:@"domain"] viewController:[PlayerViewController class] nib:@"OOplayer"];
  self.playerViewController = [self.playerViewController initWithPlayerSelectionOption:value];
  
  if((int)self.SimilarFeature >= 0){
    [self GetDiscoveryData:self.similartableview[0] typeOfhandler:[self.configuration.carousels[self.SimilarFeature] objectForKey:@"handler"] carouselConfiguration:self.configuration.carousels[self.SimilarFeature]];
  }

}


- (void) GetDiscoveryData:(UITableView*)actual_carousel typeOfhandler:handler carouselConfiguration:carouselConfig {
  //[actual_carousel registerNib:[UINib nibWithNibName:@"EmbedCell" bundle:nil] forCellReuseIdentifier:@"EmbedCell"];
  
  if(self.actualembed == nil){
    self.actualembed = [(NSDictionary *)self.configuration.initasset objectForKey:@"embedCode"];
  }
  
  
  if([handler  isEqual: @"middleware"]){
    
    NSMutableArray *middlewareResults = [NSMutableArray array];
    self.discoveryResults = [NSArray arrayWithObjects:middlewareResults, nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *urlForHttpGet = [carouselConfig objectForKey:@"url"];
    
    if ([urlForHttpGet rangeOfString:@"[embedcode]"].location != NSNotFound) {
      urlForHttpGet = [urlForHttpGet stringByReplacingOccurrencesOfString:@"[embedcode]" withString:self.actualembed];
    }
    
    [request setURL:[NSURL URLWithString:urlForHttpGet]];
    [request setHTTPMethod:@"GET"];
    
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
    }] resume];
    
  }else{ //DiscoveryApi
    
    OODiscoveryOptions *discoveryOption;
    if([[carouselConfig objectForKey:@"type"] isEqualToString: @"Momentum"]){
      discoveryOption = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypeMomentum limit:10 timeout:60];
    }else if([[carouselConfig objectForKey:@"type"] isEqualToString: @"Similar"]){
      discoveryOption = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypePopular limit:10 timeout:60];
    }else if([[carouselConfig objectForKey:@"type"] isEqualToString: @"Popular"]){
      discoveryOption = [[OODiscoveryOptions alloc] initWithType:OODiscoveryTypeSimilarAssets limit:10 timeout:60];
    }
    NSArray *discoveryOptions = [NSArray arrayWithObjects:discoveryOption, nil];
    for (NSUInteger index = 0; index < discoveryOptions.count; ++index) {
      [OODiscoveryManager getResults:discoveryOptions[index] embedCode:self.actualembed pcode:[(NSDictionary *)self.configuration.playerParameters objectForKey:@"pcode"] parameters:nil callback:^(NSArray *results, OOOoyalaError *error) {
        if (error) {
          NSLog(@"discovery request failed, error is %@", error.description);
        } else {
          
          [self insertDiscoveryResults:results toArray:self.discoveryResults[0]];
        }
      }];
    }
  }
  
  
}

- (NSString*) decodeString: (NSString*)data{
  
  NSData* stringData = [data dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary* options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
  NSAttributedString* decodedAttributedString = [[NSAttributedString alloc] initWithData:stringData options:options documentAttributes:NULL error:NULL];
  return [decodedAttributedString string];
  
}


- (void)insertDiscoveryResults:(NSArray *)results toArray:(NSMutableArray *)array {
  [array removeAllObjects];
  for (NSDictionary *dict in results) {
    NSString *name = [dict objectForKey:@"name" ];
    NSString *embedCode = [dict objectForKey:@"embed_code"];
    NSString *imageUrl = [dict objectForKey:@"preview_image_url"];
    NSNumber *duration = [NSNumber numberWithDouble:[[dict objectForKey:@"duration"] doubleValue] / 1000];
    NSString *bucketInfo = [dict objectForKey:@"bucket_info"];
    NSLog(@"receive discovery result name %@, embedCode %@, imageUrl %@, duration %@, bucketInfo %@", name, embedCode, imageUrl, [duration stringValue], bucketInfo);
    [array addObject:dict];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
