//
//  OOCastButton.h
//  
//
//  Created by Michael Len on 7/1/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OOCastButton : UIButton

- (void)startCastButtonAnimating;

- (void)updateCastButtonFrameColor:(BOOL)isConnectedToChromecast;
@end
