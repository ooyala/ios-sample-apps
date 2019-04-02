//
//  SetAssetPlayerViewController.m
//  OoyalaSkinSampleApp
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "SetAssetPlayerViewController.h"
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>
#import <OoyalaSDK/OoyalaSDK.h>

@interface SetAssetPlayerViewController()

@property (nonatomic) OOSkinViewController *skinController;

extern NSString *kFirstAssetName;
extern NSString *kSecondAssetName;
extern NSString *kAssetJSONExtension;

@end


@implementation SetAssetPlayerViewController

#pragma mark - Constants

NSString *kFirstAssetName = @"asset1";
NSString *kSecondAssetName = @"asset2";
NSString *kAssetJSONExtension = @"json";

#pragma mark - Dynamic properties

@dynamic  skinController;

#pragma mark - Private functions

- (NSDictionary *)loadJSONFromBundleWithName:(NSString *)name {
  // Load asset from local storage
  NSString *pathToTestDataJSON = [NSBundle.mainBundle pathForResource:name ofType:kAssetJSONExtension];
  
  if (!pathToTestDataJSON) {
    return NULL;
  }
  
  NSURL *urlToTestDataJSON = [NSURL fileURLWithPath:pathToTestDataJSON];
  NSData *jsonData = [NSData dataWithContentsOfURL:urlToTestDataJSON];
  
  if (!jsonData) {
    return NULL;
  }
        
  NSError *error;
  return [NSJSONSerialization JSONObjectWithData:jsonData
                                         options:NSJSONReadingAllowFragments
                                           error:&error];
}

- (void)showLoadAssetError {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:@"Error with load asset from local storage (main bundle)"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
    [alertController dismissViewControllerAnimated:YES completion:NULL];
  }];
  
  [alertController addAction:okAction];
  
  [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)setPlayerAsset:(NSDictionary *)asset {
  if (!asset) {
    [self showLoadAssetError];
    return;
  }
  
  [self.skinController.player setAsset:asset];
}

#pragma mark - Actions

- (IBAction)setFirstAssetAction:(UIButton *)sender {
  // Load first asset JSON
  NSDictionary *asset = [self loadJSONFromBundleWithName:kFirstAssetName];
  [self setPlayerAsset:asset];
}

- (IBAction)setSecondAssetAction:(UIButton *)sender {
  // Load second asset JSON
  NSDictionary *asset = [self loadJSONFromBundleWithName:kSecondAssetName];
  [self setPlayerAsset:asset];
}


@end
