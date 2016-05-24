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
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *embedCode;

- (instancetype)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode;

@end
