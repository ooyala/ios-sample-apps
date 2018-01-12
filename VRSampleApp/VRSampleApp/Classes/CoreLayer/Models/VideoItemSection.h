//
//  VideoItemSection.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VideoItemSection : NSObject

@property (nonatomic) NSArray *videoItems;
@property (nonatomic) NSString *title;

- (instancetype)initWithVideoItems:(NSArray *)videoItems andTitle:(NSString *)title;

@end
