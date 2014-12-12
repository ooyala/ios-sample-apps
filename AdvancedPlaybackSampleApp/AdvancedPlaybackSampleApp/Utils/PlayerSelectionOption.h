//
//  UIView+PlayerSelectionOption.h
//  AdvancedPlaybackSampleApp
//
//  Created by Michael Len on 12/11/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerSelectionOption : NSObject
@property (readonly) NSString *embedCode;
@property (readonly) Class viewController;
@property (readonly) NSString *title;

- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode viewController:(Class) viewController;
@end
