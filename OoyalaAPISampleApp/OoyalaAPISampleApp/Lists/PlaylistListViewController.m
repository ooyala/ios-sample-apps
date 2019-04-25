#import "PlaylistListViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "ChannelContentTreeTableViewCell.h"
#import "ChannelContentTreeDetailViewController.h"

@interface PlaylistListViewController () {
  NSMutableArray *videos;
}

@property NSString *pcode;
@property NSString *playerDomain;
@property NSString *playlistId;

@end

@implementation PlaylistListViewController
- (void)viewDidLoad {
  [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    
   
  // NOTE: hardcoded pcode and playlist ID
  self.pcode = @"c0cTkxOqALQviQIGAHWY5hP0q9gU";
  self.playlistId = @"4fef485d588a4a818f913db2089a3a7a";
  self.playerDomain = self.option.domain;

  NSString *urlString = [NSString stringWithFormat:@"https://player.ooyala.com/api/v1/playlist/%@/%@", self.pcode, self.playlistId];
  [self.tableView registerNib:[UINib nibWithNibName:@"ChannelCell" bundle:nil] forCellReuseIdentifier:@"ChannelCell"];
  NSURL *url = [NSURL URLWithString:urlString];

  // Simple synchronous network request
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
  NSHTTPURLResponse *response = nil;
  NSError *error = nil;
  NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (error) {
    LOG(@"Request FAILED URL:%@ ERROR:%@", [url absoluteString], [error description]);
  }

  // Simple JSON parsing
  NSDictionary *obj = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseData
                                                                      options:0
                                                                        error:&error];;
  NSLog(@"%@", obj);

  videos = (NSMutableArray *)[obj objectForKey:@"data"];

  [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return videos.count;
}

 
/**
 * Take each video (in reverse order) and put it into the TableView
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ChannelContentTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelCell" forIndexPath:indexPath];
  NSDictionary *video = [videos objectAtIndex:videos.count - indexPath.row - 1];

  //TODO: see the comment for urlToHTTPS
  NSString *imageUrl = [self urlToHTTPS:[video objectForKey:@"image"]];
  [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    cell.thumbnail.image = [UIImage imageWithData:data];
  }];
  cell.duration.text = [NSString stringWithFormat:@"%@", [video objectForKey:@"duration"]];
  cell.title.text = [video objectForKey:@"name"];
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
  NSDictionary *video = [videos objectAtIndex:videos.count - indexPath.row - 1];
  PlayerSelectionOption *selection = [[PlayerSelectionOption alloc] initWithTitle:[video objectForKey:@"name"]
                                                                        embedCode:[video objectForKey:@"embed_code"]
                                                                            pcode:self.pcode
                                                                           domain:self.playerDomain
                                                                   viewController:[ChannelContentTreeDetailViewController class]];
  ChannelContentTreeDetailViewController *controller = [[ChannelContentTreeDetailViewController alloc] initWithPlayerSelectionOption:selection qaModeEnabled:self.qaModeEnabled];
    controller.qaModeEnabled = self.qaModeEnabled;
    
  [self.navigationController pushViewController:controller animated:YES];
}

/**
 * TODO: This method is temporary, as the playlist API does not return SSL-enabled thumbnails.  For now, replace all http strings with htttps for thumbnail urls
 */
- (NSString *) urlToHTTPS:(NSString *)url {
  NSMutableString *str = [NSMutableString stringWithString:url];
  [str replaceOccurrencesOfString:@"http://" withString:@"https://" options:NSLiteralSearch range:NSMakeRange(0, [str length])];
  return str;
}

@end
