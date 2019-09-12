//
//  OOPiPButton.h
//  OoyalaSDK
//
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@interface OOPiPButton : UIButton

/**
 Use setter for changing icon on Picture-In-Picture button.
 
          for iOS 9 and up only
 
 Set YES to use system button for state Picture-In-Picture activated.
 
 @code
 [AVPictureInPictureController  pictureInPictureButtonStartImageCompatibleWithTraitCollection:nil]
 @endcode
 
          Set NO to use system button for state Picture-In-Picture not activated
 @code
 [AVPictureInPictureController pictureInPictureButtonStopImageCompatibleWithTraitCollection:nil]
 @endcode
 
 @return YES if button shows icon for activated mode, NO otherwise
 */
@property (nonatomic, getter=isPiPActive) BOOL isPiPActive;

@end
