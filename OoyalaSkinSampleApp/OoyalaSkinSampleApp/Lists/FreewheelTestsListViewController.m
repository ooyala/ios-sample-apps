//
//  FreewheelTestsListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "FreewheelTestsListViewController.h"
#import "FreewheelPlayerViewController.h"

@interface FreewheelTestsListViewController ()

@end

@implementation FreewheelTestsListViewController

- (void)addTestCases {
  self.options = [NSArray array];
  self.options = @[
                   [self optionWithTitle:@"Freewheel Preroll"
                               embedCode:@"Q5MXg2bzq0UAXXMjLIFWio_6U0Jcfk6v"],
                   [self optionWithTitle:@"Freewheel Midroll"
                               embedCode:@"NwcGg4bzrwxc6rqAZbYij4pWivBsX57a"],
                   [self optionWithTitle:@"Freewheel Postroll"
                               embedCode:@"NmcGg4bzqbeqXO_x9Rfj5IX6gwmRRrse"],
                   [self optionWithTitle:@"Freewheel PreMidPost"
                               embedCode:@"NqcGg4bzoOmMiV35ZttQDtBX1oNQBnT-"],
                   [self optionWithTitle:@"Freewheel Overlay"
                               embedCode:@"NucGg4bzrVrilZrMdlSA9tyg6Vty46DN"],
                   [self optionWithTitle:@"Freewheel PreMidPost Overlay"
                               embedCode:@"NscGg4bzpO9s5rUMyW-AAfoeEA7CX6hP"],
                   [self optionWithTitle:@"Freewheel Multi Midroll"
                               embedCode:@"htdnB3cDpMzXVL7fecaIWdv9rTd125As"],

                   ];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title
                                 embedCode:(NSString *)embedCode {
  NSString *pcode =@"V0NDYyOuL4a4eLle69su0dP_7vs1";
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"DefaultSkinPlayerView";
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                       viewController:FreewheelPlayerViewController.class
                                                  nib:nib];
}

@end
