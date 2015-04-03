//
//  AdobePassViewController.h
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaSDK/OOEmbedTokenGenerator.h>

extern int const PASS_SUCCESS;
extern int const PASS_FAILURE;

@protocol AdobePassViewControllerDelegate
- (void)authChanged:(int)status;
@end

@interface AdobePassViewController : UIViewController <OOEmbedTokenGenerator>
@property (nonatomic, assign) id<AdobePassViewControllerDelegate> delegate;

- (id)initWithRequestor:(NSString *)requestor keystore:(NSString *)keystore keypass:(NSString *)keypass delegate:(id<AdobePassViewControllerDelegate>)delegate;
- (void)login;
- (void)logout;
- (void)checkAuth;

@end
