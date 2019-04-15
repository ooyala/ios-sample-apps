//
//  PlayerViewController.h
//  DownloadToOwnSampleApp
//
//  Created on 8/30/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

@import UIKit;
@class OODtoAsset;

@interface PlayerViewController : UIViewController
/**
 OODtoAsset to play from, either online or offline
 */
@property (nonatomic) OODtoAsset *dtoAsset;

@end
