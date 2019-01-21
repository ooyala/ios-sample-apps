//
//  BrowseButton.m
//  Discovery
//
//  Created on 9/7/17.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "BrowseButton.h"

@implementation BrowseButton

@synthesize titleLabel;

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]){
    self.transparentView = [[UIView alloc] initWithFrame:frame];
    self.transparentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    //[self addSubview:self.transparentView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 160, 50)];
    self.titleLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:12.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
  }
  return self;
}

@end
