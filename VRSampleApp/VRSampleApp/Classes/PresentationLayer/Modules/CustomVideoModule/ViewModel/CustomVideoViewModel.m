//
//  CustomVideoViewModel.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "CustomVideoViewModel.h"


@interface CustomVideoViewModel ()

@property (nonatomic) NSString *pCode;
@property (nonatomic) NSString *embedCode;

@end

@implementation CustomVideoViewModel

#pragma mark - Initialziation

- (instancetype)init {
  if (self = [super init]) {
    _pCode = @"";
    _embedCode = @"";
  }
  
  return self;
}

#pragma mark - Public functions

- (void)pCodeDidUpdated:(NSString *)pCode {
  self.pCode = pCode;
  
  [self updateOpenButtonState];
}

- (void)embedCodeDidUpdated:(NSString *)embedCode {
  self.embedCode = embedCode;
  
  [self updateOpenButtonState];
}

- (void)openButtonDidTapped {
  if (![self.embedCode isEqual:@""] && ![self.pCode isEqual:@""]) {
    __weak typeof(self) weakSelf = self;

    [self.delegate dismisCurrentModule:^(BOOL finished) {
      weakSelf.completionBlock(weakSelf.pCode, weakSelf.embedCode);
    }];
  }
}

#pragma mark - Private functions

- (void)updateOpenButtonState {
  [self.delegate openButtonEnabledChanged:![self.embedCode isEqual:@""] && ![self.pCode isEqual:@""]];
}

@end
