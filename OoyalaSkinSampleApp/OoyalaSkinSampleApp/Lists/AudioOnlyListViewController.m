//
//  AudioOnlyListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "AudioOnlyListViewController.h"
#import "AudioOnlySkinPlayerViewController.h"

@implementation AudioOnlyListViewController

- (void)addTestCases {
  self.options = [NSArray array];
  self.options = @[
                   [self optionWithTitle:@"Audio delivery"
                               embedCode:@"A3aTBmZzE6bzQUkQlDOrUu4cjfOlCGPa"
                                   pcode:@"Q1bW0yOsRxnrzAjzXI2wUlZp9h53"],

                   [self optionWithTitle:@"Audio HLS delivery"
                               embedCode:@"NybzBmZzE6n6LYZgsxJNthUnAn1_xrcV"
                                   pcode:@"Q1bW0yOsRxnrzAjzXI2wUlZp9h53"],

                   [self optionWithTitle:@"Audio long"
                               embedCode:@"I4cDBmZzE6GRYVnZyNOBhmeVUEi_DluP"
                                   pcode:@"Q1bW0yOsRxnrzAjzXI2wUlZp9h53"],

                   [self optionWithTitle:@"Audio live"
                               embedCode:@"kzNG14ZzE6jB86edI73oJxUl8fF_WsNg"
                                   pcode:@"s0dmoyOpUmxi2TF1Z96XyYluCu1D"]
                   ];
}

- (PlayerSelectionOption *)optionWithTitle:(NSString *)title
                                 embedCode:(NSString *)embedCode
                                     pcode:(NSString *)pcode {
  NSString *playerDomain = @"http://www.ooyala.com";
  NSString *nib = @"AudioOnlyPlayerViewController";
  return [[PlayerSelectionOption alloc] initWithTitle:title
                                            embedCode:embedCode
                                                pcode:pcode
                                         playerDomain:playerDomain
                                       viewController:AudioOnlySkinPlayerViewController.class
                                                  nib:nib];
}

@end
