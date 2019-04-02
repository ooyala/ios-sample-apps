//
//  SkinPlayerViewController.h
//  ChromecastSampleApp
//
//  Created on 4/2/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#ifndef SkinPlayerViewController_h
#define SkinPlayerViewController_h

@import UIKit;
@class ChromecastPlayerSelectionOption;

@interface SkinPlayerViewController : UIViewController

- (instancetype)initWithPlayerSelectionOption:(ChromecastPlayerSelectionOption *)playerSelectionOption;

@end

#endif /* SkinPlayerViewController_h */
