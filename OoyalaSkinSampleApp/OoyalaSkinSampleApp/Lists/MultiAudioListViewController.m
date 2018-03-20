//
//  MultiAudioListViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "MultiAudioListViewController.h"


@interface MultiAudioListViewController ()

@end


@implementation MultiAudioListViewController

- (void)addTestCases {
  
  [self addCommonWithTitle:@"English/German tracks" embedCode:@"wxNjRwZTE6bxMBkrQbfM_BwokGf0pyOm" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Undefined/Undefined asset1" embedCode:@"xmaTRwZTE6lCuPd3H82AteBFUvNHtrHu" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Undefined/Undefined asset2" embedCode:@"Y1cTRwZTE6Mc47fc_8n161HVYQYu5l0d" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"No config Eng main+commentary/Ger main+commentary" embedCode:@"txcjRwZTE6aMSqloxZZ3hZhTqz5hEaY9" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Config Eng main+commentary/Ger main+commentary" embedCode:@"EweDRwZTE6ipjPDynkEotrpTvvYgDvr7" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
  [self addCommonWithTitle:@"Mixed language code/Undefined" embedCode:@"o3eTRwZTE6TBJnp6gPJia25dtOcrugUk" pcode:@"k0a2gyOt0QGNJLSuzKfdY4R-hw2b"];
}

@end
