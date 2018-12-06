//
//  AdobePassUiResponder.h
//  AdobePassDemoApp
//
//  Created on 5/16/12.
//  Copyright © 2012 Ooyala Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdobePassUiDelegate
- (void)providerSelected:(NSString *)mvpdId;
- (void)navigatedBackToApp;
@end
