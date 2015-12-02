//
//  CustomizedMiniControllerView.m
//  ChromecastSampleApp
//
//  Created by Liusha Huang on 9/25/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import "CustomizedMiniControllerView.h"
#import <OoyalaCastSDK/OOCastManager.h>
#import <OoyalaCastSDK/OOCastPlayer.h>

@interface CustomizedMiniControllerView()
@property(nonatomic, strong) OOCastManager *castManager;
@property(nonatomic, weak) id<OOCastMiniControllerDelegate> delegate;
@property(nonatomic, strong) UIImage *playImage;
@property(nonatomic, strong) UIImage *pauseImage;
@end

@implementation CustomizedMiniControllerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame castManager:(OOCastManager *)castManager delegate:(id<OOCastMiniControllerDelegate>)delegate {
  self = [super initWithFrame:frame];
  if (self) {
    self.castManager = castManager;
    self.delegate = delegate;
    self.cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    self.cell.backgroundColor = [UIColor lightGrayColor];
    self.cell.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.cell.textLabel.text = self.castManager.castPlayer.castItemTitle;
    self.cell.detailTextLabel.text = self.castManager.castPlayer.castItemTitle;
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Accessory is the play/pause button.
    self.pauseImage = [UIImage imageNamed:@"pause.png"];
    self.playImage = [UIImage imageNamed:@"play.png"];
    BOOL playing = (self.castManager.castPlayer.state == OOOoyalaPlayerStatePlaying ||
                    self.castManager.castPlayer.state == OOOoyalaPlayerStateLoading);
    UIImage *buttonImage = (playing ? self.pauseImage : self.playImage);
    CGRect buttonFrame = CGRectMake(0, 0,  self.frame.size.height * 2 / 3, self.frame.size.height * 2 / 3);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(playPausePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.cell.accessoryView = button;


    UIImageView *mediaThumb = self.cell.imageView;
    [mediaThumb setImage:[UIImage imageNamed:@"ooyala_logo.png"]];
    [self.cell setNeedsLayout];
    [self addSubview:self.cell];
  }
  return self;
}

- (void)playPausePressed:(id)sender {
  if (self.castManager.castPlayer.state == OOOoyalaPlayerStatePlaying) {
    [self.castManager.castPlayer pause];
  } else {
    [self.castManager.castPlayer play];
  }

}

- (void)updatePlayState:(BOOL)isPlaying {
  UIImage *buttonImage;
  if (isPlaying) {
    buttonImage = self.pauseImage;
  } else {
    buttonImage = self.playImage;
  }
  // change the icon.
  [((UIButton *)self.cell.accessoryView) setBackgroundImage:buttonImage forState:UIControlStateNormal];
}

- (void)dismiss {
  [self removeFromSuperview];
  [self.delegate onDismissMiniController:self];
}
@end
