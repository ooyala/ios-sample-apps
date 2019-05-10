//
//  SkinCastPlaybackView.m
//  ChromecastSampleApp
//
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import <OoyalaSDK/OOVideo.h>
#import "SkinCastPlaybackView.h"
#import "Utils.h"

@interface SkinCastPlaybackView ()

@property (nonatomic) UITextView *textView;

@end

@implementation SkinCastPlaybackView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
  }
  return self;
}

- (void)configureCastPlaybackViewBasedOnItem:(OOVideo *)item {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [UIImage imageWithData:[Utils getDataFromImageURL:item.promoImageURL]];
    dispatch_sync(dispatch_get_main_queue(), ^{
      [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
      self.image = image;
    });
  });
}

@end
