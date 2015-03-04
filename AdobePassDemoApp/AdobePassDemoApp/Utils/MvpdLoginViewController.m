//
//  MvpdLoginViewController.m
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MvpdLoginViewController.h"

@interface MvpdLoginViewController ()
@property (assign) id<AdobePassUiDelegate> delegate;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation MvpdLoginViewController

@synthesize delegate, webView;

- (id)initWithString:(NSString *)url delegate:(id<AdobePassUiDelegate>)_delegate {
  return [self initWithUrl:[NSURL URLWithString:url] delegate:_delegate];
}

- (id)initWithUrl:(NSURL *)url delegate:(id<AdobePassUiDelegate>)_delegate {
  self = [self init];
  
  if (self) {
    delegate = _delegate;
    webView = [[UIWebView alloc] init];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [webView setDelegate:self];
    [self setTitle:@"Login"];
    [self setView:webView];
  }

  return self;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  if ([(NSString *)[[error userInfo] objectForKey:@"NSErrorFailingURLStringKey"] isEqualToString:ADOBEPASS_REDIRECT_URL]) {
    [delegate navigatedBackToApp];     
  }
}

@end
