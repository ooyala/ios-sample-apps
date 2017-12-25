//
//  Mappable.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//


@protocol Mappable <NSObject>

+ (id)createFromJSON:(id)json;
+ (id)createCollectionFromJSON:(id)json;
+ (id)createCollectionFromArrayJSON:(id)json;

@end
