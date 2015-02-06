//
//Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOStreamPlayerMappingCreator.h"


@interface OOStreamPlayerMappingClassCreator : NSObject<OOStreamPlayerMappingCreator>
-(instancetype) init __attribute__((unavailable("use initWithClass")));
-(instancetype) initWithClass:(Class)class;
@end