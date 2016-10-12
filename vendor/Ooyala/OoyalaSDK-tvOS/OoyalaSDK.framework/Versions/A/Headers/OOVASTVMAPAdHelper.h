//
//  OOVASTVMAPAdHelper.h
//  OoyalaSDK
//
//  Created by Yi Gu on 3/21/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOTBXML.h"

@interface OOVASTVMAPAdHelper : NSObject

+ (BOOL)parse:(OOTBXMLElement *)e adSpots:(NSMutableArray *)adSpots duration:(NSInteger)duration;
+ (OOTBXMLElement *)firstElement:(OOTBXMLElement *)e byName:(NSString *)name;
@end
