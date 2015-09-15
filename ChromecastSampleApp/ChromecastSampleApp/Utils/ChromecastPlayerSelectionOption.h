/**
 * @class      ChromecastPlayerSelectionOption ChromecastPlayerSelectionOption.h "ChromecastPlayerSelectionOption.h"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface ChromecastPlayerSelectionOption : NSObject
@property NSString *embedCode;
@property NSString *embedCode2;
@property NSString *title;
@property NSString *pcode;
@property NSString *domain;
@property NSString *nib;
@property Class viewController;

- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode: (NSString *)pcode domain:(NSString *)domain viewController:(Class)viewController;
- (id)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode embedCode2:(NSString *)embedCode2 pcode: (NSString *)pcode domain:(NSString *)domain viewController:(Class)viewController;

@end
