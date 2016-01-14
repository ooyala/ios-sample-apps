//
//  CastPlaybackView.m
//  ChromecastSampleApp
//

#import "CastPlaybackView.h"
#import "Utils.h"

@interface CastPlaybackView()
@property (nonatomic, weak) UIView *parentView;
@property (nonatomic) UITextView *textView;
@end

@implementation CastPlaybackView

-(instancetype) initWithParentView:(UIView*)parentView {
  CGRect f = CGRectMake(0, 0, parentView.frame.size.width, parentView.frame.size.height);
  self = [super initWithFrame:f];
  if( self ) {
    self.parentView = parentView;
  }
  return self;
}

-(void) configureCastPlaybackViewBasedOnItem:(OOVideo*)item displayName:(NSString*)displayName displayStatus:(NSString*)displayStatus {
  if( self.textView == nil ) {
    [self buildPlaybackView:item];
  }
  [self updateTextView:item displayName:displayName displayStatus:displayStatus];
}

-(void) buildPlaybackView:(OOVideo*)item {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [UIImage imageWithData:[Utils getDataFromImageURL:item.promoImageURL]];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
      self.image = image;
      [self.layer setBorderColor:[UIColor redColor].CGColor];
      [self.layer setBorderWidth:5.0];
      self.contentMode = UIViewContentModeScaleAspectFit;
      
      self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height)];
      self.textView.userInteractionEnabled = NO;
      [self.textView setFont:[UIFont boldSystemFontOfSize:30]];
      self.textView.textColor = [UIColor whiteColor];
      self.textView.backgroundColor = [UIColor clearColor];
      self.textView.textAlignment = NSTextAlignmentCenter;
      self.textView.center = self.parentView.center;
      [self.textView setTranslatesAutoresizingMaskIntoConstraints:NO];
      [self addSubview:self.textView];
      
      NSLayoutConstraint *w =[NSLayoutConstraint
                              constraintWithItem:self.textView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:0
                              toItem:self
                              attribute:NSLayoutAttributeWidth
                              multiplier:1.0
                              constant:0];
      NSLayoutConstraint *h =[NSLayoutConstraint
                              constraintWithItem:self.textView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:0
                              toItem:self
                              attribute:NSLayoutAttributeHeight
                              multiplier:1.0
                              constant:0];
      NSLayoutConstraint *t = [NSLayoutConstraint
                               constraintWithItem:self.textView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
      NSLayoutConstraint *l = [NSLayoutConstraint
                               constraintWithItem:self.textView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeLeading
                               multiplier:1.0f
                               constant:0.f];
      [self addConstraint:w];
      [self addConstraint:h];
      [self addConstraint:t];
      [self addConstraint:l];
    });
  });
}

-(void) updateTextView:(OOVideo*)item displayName:(NSString*)displayName displayStatus:(NSString*)displayStatus {
  if( self.textView ) {
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
