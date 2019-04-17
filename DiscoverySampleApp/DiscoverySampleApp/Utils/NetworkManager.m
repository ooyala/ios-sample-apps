//
//  NetworkManager.m
//  DiscoverySampleAppSampleApp
//
//  Created on 4/17/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (void)getMiddlewareDataForEmbedCode:(NSString *)embedCode
                    andCarouselConfig:(NSDictionary *)carouselConfig
                       withCompletion:(void (^)(NSArray *assets))callback {
  NSMutableURLRequest *request = [NSMutableURLRequest new];

  NSString *urlForHttpGet = carouselConfig[@"url"];

  if ([urlForHttpGet rangeOfString:@"[embedcode]"].location != NSNotFound) {
    urlForHttpGet = [urlForHttpGet stringByReplacingOccurrencesOfString:@"[embedcode]"
                                                             withString:embedCode];
  }

  request.URL = [NSURL URLWithString:urlForHttpGet];
  request.HTTPMethod = @"GET";

  NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];

  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData *data,
                                                                  NSURLResponse *response,
                                                                  NSError *error) {
    if (error) { callback(nil); }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    NSArray *assets = dict[carouselConfig[@"jsonRoot"]];
    NSLog(@"results: %@", assets);

    callback(assets);
  }];
  [dataTask resume];
}

@end
