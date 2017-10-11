//
//  PlayerSelectionOption.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlayerSelectionOption : NSObject

  @property (nonatomic) NSString *embedCode;
  @property (nonatomic) NSString *pcode;
  @property (nonatomic) NSString *domain;
  @property (nonatomic) NSString *title;
  
- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode:(NSString *)pcode  domain:(NSString *)domain;
  
@end
