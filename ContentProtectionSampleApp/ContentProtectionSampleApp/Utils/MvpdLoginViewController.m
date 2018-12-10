//
//  MvpdLoginViewController.m
//  AdobePassDemoApp
//
//  Created on 5/15/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import "MvpdLoginViewController.h"

@interface MvpdLoginViewController ()

@property (weak) id<AdobePassUiDelegate> delegate;
@property (nonatomic) UIWebView *webView;

@end

@implementation MvpdLoginViewController

@synthesize delegate, webView;

- (instancetype)initWithString:(NSString *)url delegate:(id<AdobePassUiDelegate>)theDelegate {
  return [self initWithUrl:[NSURL URLWithString:url] delegate:theDelegate];
}

- (instancetype)initWithUrl:(NSURL *)url delegate:(id<AdobePassUiDelegate>)theDelegate {
  if (self = [self init]) {
    delegate = theDelegate;
    self.title = @"Login";
    webView = [UIWebView new];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.view = webView;
  }
  return self;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  if ([(NSString *)error.userInfo[@"NSErrorFailingURLStringKey"] isEqualToString:ADOBEPASS_REDIRECT_URL]) {
    [delegate navigatedBackToApp];     
  }
}

@end
