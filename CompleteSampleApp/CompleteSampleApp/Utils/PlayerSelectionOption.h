//
//  UIView+PlayerSelectionOption.h
//  AdvancedPlaybackSampleApp
//
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerSelectionOption : NSObject
@property NSString *embedCode;
@property NSString *title;
@property Class viewController;

- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode viewController:(Class) viewController;
@end
