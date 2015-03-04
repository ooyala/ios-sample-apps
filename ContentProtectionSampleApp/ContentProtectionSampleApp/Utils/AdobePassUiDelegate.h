//
//  AdobePassUiResponder.h
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdobePassUiDelegate
- (void)providerSelected:(NSString *)mvpdId;
- (void)navigatedBackToApp;
@end