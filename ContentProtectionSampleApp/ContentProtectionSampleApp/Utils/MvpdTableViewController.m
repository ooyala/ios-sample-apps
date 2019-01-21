//
//  MvpdListViewController.m
//  AdobePassDemoApp
//
//  Created on 5/15/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import "MvpdTableViewController.h"
#import "MVPD.h"

@interface MvpdTableViewController ()

@property (nonatomic) NSArray *mvpds;
@property (assign) id<AdobePassUiDelegate> delegate;

@end

@interface AsyncImageLoader : NSObject

@property (nonatomic) __block UITableViewCell *cell;

- (void)loadImage:(NSString*)url intoCell:(UITableViewCell*)view;

@end

@implementation MvpdTableViewController

@synthesize mvpds, delegate;

- (instancetype)initWithMvpds:(NSArray *)theMvpds
                     delegate:(id<AdobePassUiDelegate>)theDelegate {
  if (self = [self initWithStyle:UITableViewStylePlain]) {
    delegate = theDelegate;
    mvpds = [theMvpds sortedArrayUsingComparator:^NSComparisonResult(MVPD *mvpd1, MVPD *mvpd2) {
      return [mvpd1.displayName compare:mvpd2.displayName];
    }];
    self.title = @"Select a Provider";
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
  MVPD *mvpd = mvpds[indexPath.row];

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mvpd.ID];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:mvpd.ID];
  }

  cell.textLabel.text = mvpd.displayName;
  [[AsyncImageLoader new] loadImage:mvpd.logoURL intoCell:cell];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [delegate providerSelected:[mvpds[indexPath.row] ID]];
}

@end

@implementation AsyncImageLoader

@synthesize cell;

- (void)loadImage:(NSString*)url intoCell:(UITableViewCell*)_cell {
  cell = _cell;

  NSURL *theUrl = [[NSURL alloc] initWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:theUrl];
  NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request
                                                                 completionHandler:^(NSData * _Nullable data,
                                                                                     NSURLResponse * _Nullable response,
                                                                                     NSError * _Nullable error) {
    if (error) {
      NSLog(@"Connection failed! Error - %@ %@",
            error.localizedDescription,
            error.userInfo[NSURLErrorFailingURLStringErrorKey]);
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        self->cell.imageView.image = [[UIImage alloc] initWithData:data];
        [self->cell setNeedsLayout];
        self->cell.imageView.frame = CGRectMake(0, 0, 112, 33);
        [self->cell setNeedsDisplay];
      });
    }
  }];
  [dataTask resume];
}

@end
