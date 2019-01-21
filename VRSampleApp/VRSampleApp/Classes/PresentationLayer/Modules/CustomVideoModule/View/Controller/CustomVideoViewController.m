//
//  CustomVideoViewController.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "CustomVideoViewController.h"
#import "CustomVideoTransitionManager.h"

@interface CustomVideoViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *pCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *embedCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *openButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerCenterYConstraint;
@property (nonatomic) CustomVideoTransitionManager *transitionManager;

extern CGFloat kContentViewCornerRadius;
extern CGFloat kDefaultSpacing;

@end


@implementation CustomVideoViewController

#pragma mark - Constants

CGFloat kContentViewCornerRadius = 8.0;
CGFloat kDefaultSpacing = 8.0;

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configureObjects];
  [self configureUI];
}

#pragma mark - Private properties

- (void)configureObjects {
  // Add keyboard notifications
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(keyboardNotification:)
                                             name:UIKeyboardWillShowNotification
                                           object:NULL];
  
  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(keyboardNotification:)
                                             name:UIKeyboardWillHideNotification
                                           object:NULL];
}

- (void)configureUI {
  // Transition
  self.transitionManager = [CustomVideoTransitionManager new];
  self.transitioningDelegate = self.transitionManager;
  
  // Container view
  self.containerView.layer.masksToBounds = YES;
  self.containerView.layer.cornerRadius = kContentViewCornerRadius;
}

- (void)updateUIWithKeyboardActionWithKeyboardFrame:(CGRect)keyboardFrame isShowing:(BOOL)isShowing {
  if (!isShowing) {
    self.containerCenterYConstraint.constant = 0;
    return;
  }
  
  if (self.pCodeTextField.isEditing) {
    [self updateContainerViewPostionWithPCodeTestFieldEditingWithKeyboardFrame:keyboardFrame];
  } else {
    [self updateContainerViewPostionWithKeyboardFrame:keyboardFrame andView:self.containerView];
  }
}

- (void)updateContainerViewPostionWithPCodeTestFieldEditingWithKeyboardFrame:(CGRect)keyboardFrame {
  CGRect convertedEmbedCodeTextFieldFrame = [self.embedCodeTextField convertRect:self.embedCodeTextField.bounds
                                                                          toView:self.view];
  CGFloat convertedEmbedCodeTextFieldMaxY = CGRectGetMaxY(convertedEmbedCodeTextFieldFrame);
  CGFloat delta = convertedEmbedCodeTextFieldMaxY + kDefaultSpacing - keyboardFrame.origin.y;
  
  if (delta > 0) {
    if (fabs(self.view.bounds.size.height - keyboardFrame.size.height) > self.containerView.bounds.size.height) {
      [self updateContainerViewPostionWithKeyboardFrame:keyboardFrame andView:self.containerView];
    } else {
      self.containerCenterYConstraint.constant = -(self.view.bounds.size.height / 2 - self.containerView.bounds.size.height / 2);
    }
  } else if (delta < 0 && CGRectGetMinY(self.containerView.frame) < 0) {
    self.containerCenterYConstraint.constant = 0;
  }
}

- (void)updateContainerViewPostionWithKeyboardFrame:(CGRect)keyboardFrame andView:(UIView *)view {
  CGRect convertedViewFrame = [view convertRect:view.bounds toView:self.view];
  CGFloat containerBottomMaxY = CGRectGetMaxY(convertedViewFrame);
  CGFloat delta = containerBottomMaxY + kDefaultSpacing - keyboardFrame.origin.y;
  
  self.containerCenterYConstraint.constant += -delta;
}

#pragma mark - Actions

- (IBAction)pCodeTextFieldDidChange:(UITextField *)sender {
  [self.viewModel pCodeDidUpdated:sender.text];
}

- (IBAction)embedCodeTextFieldDidChange:(UITextField *)sender {
  [self.viewModel embedCodeDidUpdated:sender.text];
}

- (IBAction)openButtonAction:(UIButton *)sender {
  [self.viewModel openButtonDidTapped];
}

- (IBAction)cancelButtonAction:(UIButton *)sender {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)tapOnViewGestureAction:(UITapGestureRecognizer *)sender {
  [self.pCodeTextField endEditing:YES];
  [self.embedCodeTextField endEditing:YES];
}

#pragma mark - Notifications

- (void)keyboardNotification:(NSNotification *)notification {
  BOOL isShowing = notification.name == UIKeyboardWillShowNotification;
  NSDictionary *userInfo = notification.userInfo;
  CGRect endFrame = [(NSValue *)userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]; // or 0
  UIViewAnimationOptions animationCurve = UIViewAnimationOptionCurveEaseInOut;

  [self updateUIWithKeyboardActionWithKeyboardFrame:endFrame isShowing:isShowing];
  
  [UIView animateWithDuration:duration delay:0 options:animationCurve animations:^{
    [self.view layoutIfNeeded];
  } completion:NULL];
}

#pragma mark - CustomVideoViewModelDelegate

- (void)openButtonEnabledChanged:(BOOL)enabled {
  [self.openButton setEnabled:enabled];
}

- (void)dismisCurrentModule:(void (^)(BOOL finished))completion {
  [self.pCodeTextField endEditing:YES];
  [self.embedCodeTextField endEditing:YES];
  
  [self dismissViewControllerAnimated:YES completion:^{
    completion(YES);
  }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.pCodeTextField) {
    [self.embedCodeTextField becomeFirstResponder];
  } else {
    [self.pCodeTextField becomeFirstResponder];
  }
  
  return YES;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  return !CGRectContainsPoint(self.containerView.frame, [touch locationInView:self.view]);
}

@end
