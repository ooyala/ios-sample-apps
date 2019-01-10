/**
 * @class      ChromecastPlayerSelectionOption ChromecastPlayerSelectionOption.h "ChromecastPlayerSelectionOption.h"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright © 2014 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

@interface ChromecastPlayerSelectionOption : NSObject

@property (readonly) NSString *embedCode;
@property (readonly) NSString *embedCode2;
@property (readonly) NSString *title;
@property (readonly) NSString *pcode;
@property (readonly) NSString *domain;
@property (readonly) NSString *nib;
@property (readonly) Class viewController;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                   embedCode2:(NSString *)embedCode2
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController;

@end
