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
  [self insertNewObject:[[PlayerSelectionOption alloc] initWithTitle:@"Audio delivery"
                                                           embedCode:@"A3aTBmZzE6bzQUkQlDOrUu4cjfOlCGPa"
                                                               pcode:@"Q1bW0yOsRxnrzAjzXI2wUlZp9h53"
                                                        playerDomain:@"http://www.ooyala.com"
                                                      viewController:AudioOnlySkinPlayerViewController.class
                                                                 nib:@"AudioOnlyPlayerViewController"]];
  
  [self insertNewObject:[[PlayerSelectionOption alloc] initWithTitle:@"Audio HLS delivery"
                                                           embedCode:@"NybzBmZzE6n6LYZgsxJNthUnAn1_xrcV"
                                                               pcode:@"Q1bW0yOsRxnrzAjzXI2wUlZp9h53"
                                                        playerDomain:@"http://www.ooyala.com"
                                                      viewController:AudioOnlySkinPlayerViewController.class
                                                                 nib:@"AudioOnlyPlayerViewController"]];
  
  [self insertNewObject:[[PlayerSelectionOption alloc] initWithTitle:@"Audio long"
                                                           embedCode:@"I4cDBmZzE6GRYVnZyNOBhmeVUEi_DluP"
                                                               pcode:@"Q1bW0yOsRxnrzAjzXI2wUlZp9h53"
                                                        playerDomain:@"http://www.ooyala.com"
                                                      viewController:AudioOnlySkinPlayerViewController.class
                                                                 nib:@"AudioOnlyPlayerViewController"]];

  [self insertNewObject:[[PlayerSelectionOption alloc] initWithTitle:@"Audio live"
                                                           embedCode:@"kzNG14ZzE6jB86edI73oJxUl8fF_WsNg"
                                                               pcode:@"s0dmoyOpUmxi2TF1Z96XyYluCu1D"
                                                        playerDomain:@"http://www.ooyala.com"
                                                      viewController:AudioOnlySkinPlayerViewController.class
                                                                 nib:@"AudioOnlyPlayerViewController"]];
}

@end
