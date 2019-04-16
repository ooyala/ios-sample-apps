//
//  PlayerViewController.h
//  OoyalaSkin
//
//  Created on 6/3/15.
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

#import "SampleAppPlayerViewController.h"

@protocol PlayerViewControllerDelegate <NSObject>

- (void)didUpdateAssetTitle:(NSString *)title;
- (void)didStartPlaying;

@end

@interface PlayerViewController : SampleAppPlayerViewController

@property (nonatomic, weak) id<PlayerViewControllerDelegate> delegate;

- (void)setCustomSkin;

@end
