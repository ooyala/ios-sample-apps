//
//  CustomVideoViewModel.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CustomVideoViewModelDelegate
  
- (void)openButtonEnabledChanged:(BOOL)enabled;
- (void)dismisCurrentModule:(void (^)(BOOL finished))completion;
  
@end


typedef void(^CustomVideoCompletionBLock)(NSString *pCode, NSString *embedCode);

@interface CustomVideoViewModel : NSObject

@property (nonatomic, weak) id <CustomVideoViewModelDelegate>delegate;
@property (nonatomic) CustomVideoCompletionBLock completionBlock;

- (void)pCodeDidUpdated:(NSString *)pCode;
- (void)embedCodeDidUpdated:(NSString *)embedCode;
- (void)openButtonDidTapped;

@end
