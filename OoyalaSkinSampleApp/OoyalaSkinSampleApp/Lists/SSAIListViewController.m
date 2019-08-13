//
//  SSAIListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SSAIListViewController.h"
#import "SSAIPlayerViewController.h"

@interface SSAIListViewController ()

@end

@implementation SSAIListViewController

- (void)addTestCases {
  self.options = [NSArray array];
  self.options = @[
                   [self optionWithTitle:@"SSAI / VOD / Ooyala Pulse " //@"PLAYER-4221"
                               embedCode:@"cxM3NlZzE6tLqRQWj43hP2SGtJpnmHsj"
                                   pcode:@"JvYWsyOr0ubFQBsEYCtxqD3CURPO"
                           adSetProvider:@"ooyala_pulse"],
                   
                   [self optionWithTitle:@"SSAI / VOD / Google DFP"
                               embedCode:@"ZhbzNiZzE64qnD5YMEnoi2DcwqSfH4z8"
                                   pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                           adSetProvider:@"google_dfp"],
                   
                   [self optionWithTitle:@"SSAI / VOD / Ooyala Pulse / CC DFXP"
                               embedCode:@"8yZXE0ZzE6596qdcG58aTnvzADUBLC2I"
                                   pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                           adSetProvider:@"ooyala_pulse"],
                   
                   [self optionWithTitle:@"SSAI / VOD / Google DFP / CC DFXP"
                               embedCode:@"54ZHE0ZzE6JQBu_T099L8NWvzzqsnrKG"
                                   pcode:@"ZsdGgyOnugo44o442aALkge_dVVK"
                           adSetProvider:@"google_dfp"],
                   
                   [self optionWithTitle:@"SSAI / LIVE / Ooyala Pulse"
                               embedCode:@"lkb2cyZjE6wp94YSGIEjm6Em1yH0P3zT"
                                   pcode:@"RpOWUyOq86gFq-STNqpgzhzIcXHV"
                           adSetProvider:@"ooyala_pulse"],
                   
                   [self optionWithTitle:@"SSAI / LIVE / Google DFP"
                               embedCode:@"s2M213ZDE6A-DU2Tr-k0DI-8PgnFIcmU"
                                   pcode:@"RpOWUyOq86gFq-STNqpgzhzIcXHV"
                           adSetProvider:@"google_dfp"]
                   ];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title
                                 embedCode:(NSString *)embedCode
                                     pcode:(NSString *)pcode
                             adSetProvider:(NSString *)provider {
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"SSAIPlayerViewController";
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                        adSetProvider:provider
                                       viewController:SSAIPlayerViewController.class
                                                  nib:nib];
}

@end
