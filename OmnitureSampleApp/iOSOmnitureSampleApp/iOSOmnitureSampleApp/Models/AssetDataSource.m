//
//  AssetDataSource.m
//  iOSOmnitureSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "AssetDataSource.h"
#import "PlayerSelectionOption.h"

@implementation AssetDataSource

+ (NSArray *)assets {
  return @[[[PlayerSelectionOption alloc] initWithTitle:@"MP4 video"
                                                  pcode:@"c0cTkxOqALQviQIGAHWY5hP0q9gU"
                                              embedCode:@"h4aHB1ZDqV7hbmLEv4xSOx3FdUUuephx"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Preroll"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                              embedCode:@"M4cmp0ZDpYdy8kiL4UD910Rw_DWwaSnU"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Midroll"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                              embedCode:@"xhcmp0ZDpnDB2-hXvH7TsYVQKEk_89di"],
           [[PlayerSelectionOption alloc] initWithTitle:@"Ooyala Postroll"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                              embedCode:@"Rjcmp0ZDr5yFbZPEfLZKUveR_2JzZjMO"],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST Preroll"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                              embedCode:@"Zlcmp0ZDrpHlAFWFsOBsgEXFepeSXY4c"],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST Midroll"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                              embedCode:@"pncmp0ZDp7OKlwTPJlMZzrI59j8Imefa"],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST Postroll"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                              embedCode:@"Zpcmp0ZDpaB-90xK8MIV9QF973r1ZdUf"],];
}

@end
