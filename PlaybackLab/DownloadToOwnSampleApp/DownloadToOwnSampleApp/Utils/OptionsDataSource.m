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
           // Fairplay assets require an embedTokenGenerator instance.
           // We provide an example, use BasicEmbedTokenGenerator to test your own assets too.
           [[PlayerSelectionOption alloc] initWithTitle:@"HLS Fairplay (unconfigured)"
                                              embedCode:@"cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ"
                                                  pcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                 domain:@"http://www.ooyala.com"
                                    embedTokenGenerator:
            [[BasicEmbedTokenGenerator alloc] initWithPcode:@"x0b2cyOupu0FFK5hCr4zXg8KKcrm"
                                                     apiKey:@"API_KEY"
                                                  apiSecret:@"API_SECRET"
                                                  accountId:nil
                                              authorizeHost:@"http://player.ooyala.com"]],
           // Closed Captions - Multiple formats
           [[PlayerSelectionOption alloc] initWithTitle:@"Closed Captions - DFXP"
                                              embedCode:@"ljOGlqMzE65m9-MhcFAt1CTr1lEZTh_O"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Closed Captions - VTT"
                                              embedCode:@"xjNGlqMzE68288rje9drMpgRrTNOxI1I"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Closed Captions - SCC"
                                              embedCode:@"E5NWlqMzE6nxrKShm0gR4DzpM49Wl0l9"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"],
           
           // if required, add more test cases here
           ];
}

@end
