//
//  CastPlaybackView.m
//  ChromecastSampleApp
//
//  Created on 9/18/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import <OoyalaSDK/OoyalaSDK.h>
#import "CastPlaybackView.h"
#import "Utils.h"

@interface CastPlaybackView ()

@property (nonatomic) UITextView *textView;

@end

@implementation CastPlaybackView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
  }
  return self;
}

- (void)configureCastPlaybackViewBasedOnItem:(OOVideo *)item
                                 displayName:(NSString *)displayName
                               displayStatus:(NSString *)displayStatus {
  if (!self.textView) {
    [self buildPlaybackView:item];
  }
  [self updateTextView:item displayName:displayName displayStatus:displayStatus];
}

- (void)buildPlaybackView:(OOVideo *)item {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [UIImage imageWithData:[Utils getDataFromImageURL:item.promoImageURL]];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
      self.image = image;
      self.layer.borderColor = UIColor.redColor.CGColor;
      self.layer.borderWidth = 5.0;
      self.contentMode = UIViewContentModeScaleAspectFit;
      
      self.textView = [[UITextView alloc] initWithFrame:self.frame];
      self.textView.userInteractionEnabled = NO;
      self.textView.font = [UIFont boldSystemFontOfSize:30];
      self.textView.textColor = UIColor.whiteColor;
      self.textView.backgroundColor = UIColor.clearColor;
      self.textView.textAlignment = NSTextAlignmentCenter;
      self.textView.center = self.center;
      self.textView.translatesAutoresizingMaskIntoConstraints = NO;
      [self addSubview:self.textView];

      NSLayoutConstraint *horizontal = [self.textView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor];
      NSLayoutConstraint *vertical = [self.textView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
      NSLayoutConstraint *width = [self.textView.widthAnchor constraintEqualToAnchor:self.widthAnchor];
      NSLayoutConstraint *height = [self.textView.heightAnchor constraintEqualToAnchor:self.heightAnchor];
      [NSLayoutConstraint activateConstraints:@[horizontal, vertical, width, height]];
    });
  });
}

- (void)updateTextView:(OOVideo *)item
           displayName:(NSString *)displayName
         displayStatus:(NSString *)displayStatus {
  if (self.textView) {
    dispatch_async( dispatch_get_main_queue(), ^{
      NSString *videoTitle = item.title;
      NSString *videoDescription = item.itemDescription;
      self.textView.text = [NSString stringWithFormat:@"\n\n Title: %@\n\n Description: %@\n\n Receiver: %@\n\n State: %@",
                            videoTitle,
                            videoDescription,
                            displayName,
                            displayStatus];
    });
  }
}

@end
