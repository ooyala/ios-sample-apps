//
//  OOOoyalaWeakWrapper.h
//  OoyalaSDK
//
//  Created by Zhihui Chen on 8/3/15.
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOOoyalaWeakWrapper : NSObject

-(instancetype) __unavailable init;
-(id)initWithReference:(id)ref;

@end
