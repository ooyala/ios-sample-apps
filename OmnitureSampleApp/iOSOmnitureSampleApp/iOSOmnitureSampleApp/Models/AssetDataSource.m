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
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST Multi Preroll"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                              embedCode:@"trNnFwdTogG_HxAgEV01zWLg3o8umVEJ"],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST 3.0 - Podded"
                                                  pcode:@"ltOGIyOq4Waxz7r-q6FsUpEfl4dg"
                                              embedCode:@"tjN2h1MDE65xMHMqNvvU0fYVBi6sFl1M"],
           [[PlayerSelectionOption alloc] initWithTitle:@"VAST 3.0 - VMAP PreMidPost"
                                                  pcode:@"BidTQxOqebpNk1rVsjs2sUJSTOZc"
                                              embedCode:@"41MzA5MTE65SC6VQAS3H3d9rX-hwHQSK"],
           [[PlayerSelectionOption alloc] initWithTitle:@"FW Preroll"
                                                  pcode:@"V0NDYyOuL4a4eLle69su0dP_7vs1"
                                              embedCode:@"Q5MXg2bzq0UAXXMjLIFWio_6U0Jcfk6v"],
           [[PlayerSelectionOption alloc] initWithTitle:@"FW Midroll"
                                                  pcode:@"V0NDYyOuL4a4eLle69su0dP_7vs1"
                                              embedCode:@"NwcGg4bzrwxc6rqAZbYij4pWivBsX57a"],
           [[PlayerSelectionOption alloc] initWithTitle:@"FW Postroll"
                                                  pcode:@"V0NDYyOuL4a4eLle69su0dP_7vs1"
                                              embedCode:@"NmcGg4bzqbeqXO_x9Rfj5IX6gwmRRrse"],
           [[PlayerSelectionOption alloc] initWithTitle:@"FW PreMidPost"
                                                  pcode:@"V0NDYyOuL4a4eLle69su0dP_7vs1"
                                              embedCode:@"NqcGg4bzoOmMiV35ZttQDtBX1oNQBnT-"],];
}

@end
