/**
 * @class      PlayerSelectionOption PlayerSelectionOption.m "PlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface PlayerSelectionOption : NSObject
@property NSString *embedCode;
@property NSString *title;
@property NSString *nib;
@property Class viewController;

- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode viewController:(Class)viewController;
@end
