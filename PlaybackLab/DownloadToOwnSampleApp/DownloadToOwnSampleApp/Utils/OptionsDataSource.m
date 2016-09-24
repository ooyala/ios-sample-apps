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
                                                                                                 apiKey:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm.-s6jH"
                                                                                              apiSecret:@"ZCMQt2CCVqlHWce6dG5w2WA6fkAM_JaWgoI_yzQp"
                                                                                              accountId:nil
                                                                                          authorizeHost:@"http://player.ooyala.com"]],
//
//           [[PlayerSelectionOption alloc] initWithTitle:@"HLS Fairplay High Profile"
//                                              embedCode:@"d2dzhnMzE6h-LTaIavPD5k2eqLeCTMC5"
//                                                  pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
//                                                 domain:@"http://www.ooyala.com"
//                                         viewController:nil
//                                    embedTokenGenerator:[[BasicEmbedTokenGenerator alloc] initWithPcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
//                                                                                                 apiKey:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm.-s6jH"
//                                                                                              apiSecret:@"ZCMQt2CCVqlHWce6dG5w2WA6fkAM_JaWgoI_yzQp"
//                                                                                              accountId:nil
//                                                                                          authorizeHost:@"http://player.ooyala.com"]],
           ];
}

@end
