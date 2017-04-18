/**
 * @class      ChannelBrowserViewController ChannelBrowserViewController.m "ChannelBrowserViewController.m"
 * @brief      A view that displays the list of videos in a channel
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "ChannelContentTreePlayerViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "ChannelContentTreeTableViewCell.h"
#import "ChannelContentTreeDetailViewController.h"
#import "AppDelegate.h"

@interface ChannelContentTreePlayerViewController () {
  OOOrderedDictionary *videos;
  OOOoyalaAPIClient *apiClient;
}

@property NSString *pcode;
@property NSString *playerDomain;


@end

@implementation ChannelContentTreePlayerViewController{
    AppDelegate *appDel;
}
- (void)viewDidLoad {
  [super viewDidLoad];
    appDel = [[UIApplication sharedApplication] delegate];
  [self.tableView registerNib:[UINib nibWithNibName:@"ChannelCell" bundle:nil] forCellReuseIdentifier:@"ChannelCell"];
  
  if (apiClient == nil) {
    // Do any additional setup after loading the view.
    // You need to place your own API Key and Secret from your Backlot account here, so you can perfomr Content Tree requests
    // NOTE: Secrets are not safe to put into your application, so this functionality is not necessarily reccomended
    NSString *APIKEY = @"PUT YOUR API KEY HERE";
    NSString *SECRETKEY = @"PUT YOUR SECRET HERE";

    self.pcode = self.option.pcode;
    self.playerDomain = self.option.domain;
    apiClient = [[OOOoyalaAPIClient alloc] initWithAPIKey:APIKEY secret:SECRETKEY pcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];

    if (self.option.embedCode) {
      [apiClient contentTree:[NSArray arrayWithObject:self.option.embedCode] callback:^void(OOContentItem *contentItem, OOOoyalaError *error) {
        if (error) {
          LOG(@"retrieve content tree error %@", error.description);
        } else if ([contentItem isKindOfClass:[OOChannel class]]) {
          OOChannel *channel = (OOChannel *)contentItem;
          videos = channel.videos;
          [self.tableView reloadData];
        }
      }];
    }
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChannelContentTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelCell" forIndexPath:indexPath];
  OOVideo *video = [videos objectAtIndex:indexPath.row];
  NSString *imageUrl = video.promoImageURL;
  [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    cell.thumbnail.image = [UIImage imageWithData:data];
  }];
  cell.duration.text = [NSString stringWithFormat:@"%f", video.duration];
  cell.title.text = video.title;
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 106.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // When a row is selected, load its desired PlayerViewController
  OOVideo *video = [videos objectAtIndex:indexPath.row];
  PlayerSelectionOption *selection = [[PlayerSelectionOption alloc] initWithTitle:video.title
                                                                        embedCode:video.embedCode
                                                                            pcode:self.pcode
                                                                           domain:self.playerDomain
                                                                   viewController:[ChannelContentTreeDetailViewController class]];
  ChannelContentTreeDetailViewController *controller = [[ChannelContentTreeDetailViewController alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaModeEnabled ];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void) notificationHandler:(NSNotification*) notification {
    
    // Ignore TimeChangedNotificiations for shorter logs
    if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
        return;
    }
    
    NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                         [notification name],
                         [OOOoyalaPlayer playerStateToString:[self.ChannelContentTreePlayerViewController.player state]],
                         [self->ooyalaPlayerViewController.player playheadTime], appDel.count];
    NSLog(@"%@",message);
    
    //In QA Mode , adding notifications to the TextView
    if(self.qaModeEnabled==YES) {
        NSString *string = self.textView.text;
        NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@",string,message];
        [self.textView setText:appendString];
        
    }
    appDel.count++;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
