//
//  OptionsDataSource.m
//  DownloadToOwnSampleApp
//
//  Created on 8/23/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "OptionsDataSource.h"
#import "PlayerSelectionOption.h"

@implementation OptionsDataSource

+ (NSArray *)options {
  return @[
           [[PlayerSelectionOption alloc] initWithTitle:@"HLS Clear"
                                              embedCode:@"JiOTdrdzqAujYa5qvnOxszbrTEuU5HMt"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                                 domain:@"http://www.ooyala.com"],
           ];
}

@end
