//
//  MvpdListViewController.m
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MvpdTableViewController.h"
#import "MVPD.h"

@interface MvpdTableViewController ()
@property (nonatomic, strong) NSArray *mvpds;
@property (assign) id<AdobePassUiDelegate> delegate;
@end

@interface AsyncImageLoader : NSObject<NSURLConnectionDelegate>
-(void)loadImage:(NSString*)url intoCell:(UITableViewCell*)view;
@property (strong,nonatomic) NSURLConnection *connection;
@property (strong,nonatomic) NSMutableData *data;
@property (strong,nonatomic) UITableViewCell *cell;
@end

@implementation MvpdTableViewController

@synthesize mvpds, delegate;

- (id)initWithMvpds:(NSArray *)_mvpds delegate:(id<AdobePassUiDelegate>)_delegate {
  self = [self initWithStyle:UITableViewStylePlain];
  if (self) {
    delegate = _delegate;
    mvpds = [_mvpds sortedArrayUsingComparator:^NSComparisonResult(MVPD *mvpd1, MVPD *mvpd2) {
      return [mvpd1.displayName compare:mvpd2.displayName];
    }];
    [self setTitle:@"Select a Provider"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Provider"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancel)];
  }
  
  return self;
}

- (void)cancel {
  [delegate providerSelected:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return mvpds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MVPD *mvpd = [mvpds objectAtIndex:indexPath.row];

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mvpd.ID];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mvpd.ID];
  }

  cell.textLabel.text = mvpd.displayName;
  [[[AsyncImageLoader alloc] init] loadImage:mvpd.logoURL intoCell:cell];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [delegate providerSelected:[[mvpds objectAtIndex:indexPath.row] ID]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

@implementation AsyncImageLoader

@synthesize connection,data,cell;

-(void)loadImage:(NSString*)url intoCell:(UITableViewCell*)_cell {
  NSURL *theUrl = [[NSURL alloc] initWithString:url];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:theUrl];
  connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  cell = _cell;
  data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  [data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)_data {
  [data appendData:_data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  NSLog(@"Connection failed! Error - %@ %@",
        [error localizedDescription],
        [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  cell.imageView.image = [[UIImage alloc] initWithData:data];
  [cell setNeedsLayout];
  cell.imageView.frame = CGRectMake(0, 0, 112, 33);
  [cell setNeedsDisplay];
}

@end