//
//  BrowseButton.m
//  Discovery
//
//  Created by Ileana Padilla on 9/7/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrowseButton.h"

@implementation BrowseButton
@synthesize titleLabel;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  if(self != nil){
    
    self.transparentView = [[UIView alloc]initWithFrame:frame];
    self.transparentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    //[self addSubview:self.transparentView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 160, 50)];
    self.titleLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:12.0 ];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
  }
  
  return self;
  
}

@end
