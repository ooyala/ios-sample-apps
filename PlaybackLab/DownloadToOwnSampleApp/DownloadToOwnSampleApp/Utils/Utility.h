//
//  Utility.h
//  DownloadToOwnSampleApp
//
//  Created on 11/23/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Utility : NSObject

/**
 Return if network conditions and settings allow to download an asset.

 @return YES if the asset should be downloaded, NO otherwhise.
 */
+(BOOL)shouldDownload;

@end
