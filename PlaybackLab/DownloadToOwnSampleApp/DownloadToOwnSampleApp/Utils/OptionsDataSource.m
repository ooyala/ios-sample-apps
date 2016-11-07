//
//  OptionsDataSource.m
//  DownloadToOwnSampleApp
//
//  Created on 8/23/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "OptionsDataSource.h"
#import "PlayerSelectionOption.h"
#import "BasicEmbedTokenGenerator.h"

@implementation OptionsDataSource

+ (NSArray *)options {
  return @[
           [[PlayerSelectionOption alloc] initWithTitle:@"HLS Clear"
                                              embedCode:@"JiOTdrdzqAujYa5qvnOxszbrTEuU5HMt"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"],
           
           [[PlayerSelectionOption alloc] initWithTitle:@"HLS Fairplay Main Profile"
                                              embedCode:@"cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ"
                                                  pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:nil
                                    embedTokenGenerator:[[BasicEmbedTokenGenerator alloc] initWithPcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                                                                 apiKey:@"API_KEY"
                                                                                              apiSecret:@"SECRET"
                                                                                              accountId:nil
                                                                                          authorizeHost:@"http://player.ooyala.com"]],
           
           [[PlayerSelectionOption alloc] initWithTitle:@"[AT-3304] FPS Unified"
                                              embedCode:@"ozOTM4NzE6LaONM7zKiTQGbbultNrMfM"
                                                  pcode:@"02dDQyOmJ2ryGyUV5nE9nVUt9hCW"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:nil
                                    embedTokenGenerator:[[BasicEmbedTokenGenerator alloc] initWithPcode:@"02dDQyOmJ2ryGyUV5nE9nVUt9hCW"
                                                                                                 apiKey:@"API_KEY"
                                                                                              apiSecret:@"SECRET"
                                                                                              accountId:nil
                                                                                          authorizeHost:@"http://player.ooyala.com"]],
           [[PlayerSelectionOption alloc] initWithTitle:@"[AT-3304] FPS Elemental"
                                              embedCode:@"JmZDM4NzE64pKEqRDBvp98mJpOny9lWj"
                                                  pcode:@"02dDQyOmJ2ryGyUV5nE9nVUt9hCW"
                                                 domain:@"http://www.ooyala.com"
                                         viewController:nil
                                    embedTokenGenerator:[[BasicEmbedTokenGenerator alloc] initWithPcode:@"02dDQyOmJ2ryGyUV5nE9nVUt9hCW"
                                                                                                 apiKey:@"API_KEY"
                                                                                              apiSecret:@"SECRET"
                                                                                              accountId:nil
                                                                                          authorizeHost:@"http://player.ooyala.com"]],
           ];
}

@end
