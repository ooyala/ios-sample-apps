//
//  DemoSettings.h
//  OoyalaSkinSampleApp
//
//  Created on 4/25/17.
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoSettings : NSObject

@property NSMutableArray *playerParameters;
@property NSMutableArray *initasset;
@property NSMutableArray *carousels;

//- (instancetype)initReadJSONString:(NSString *)JSONString;
- (instancetype) getLabels:(NSArray *) elements;
- (instancetype)initReadJSONFile;

@end
