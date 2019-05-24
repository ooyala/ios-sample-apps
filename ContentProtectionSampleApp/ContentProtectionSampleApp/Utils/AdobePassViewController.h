//
//  AdobePassViewController.h
//  ContentProtectionSampleApp
//
//  Created on 5/16/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaSDK/OoyalaSDK.h>

extern int const PASS_SUCCESS;
extern int const PASS_FAILURE;

@protocol AdobePassViewControllerDelegate
- (void)authChanged:(int)status;
@end

@interface AdobePassViewController : UIViewController <OOEmbedTokenGenerator>

@property (nonatomic, assign) id<AdobePassViewControllerDelegate> delegate;

- (instancetype)initWithRequestor:(NSString *)requestor
                         keystore:(NSString *)keystore
                          keypass:(NSString *)keypass
                         delegate:(id<AdobePassViewControllerDelegate>)delegate;
- (void)login;
- (void)logout;
- (void)checkAuth;

@end
