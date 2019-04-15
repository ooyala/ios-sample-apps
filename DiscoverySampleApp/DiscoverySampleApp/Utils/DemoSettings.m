//
//  DemoSettings.m
//  OoyalaSkinSampleApp
//
//  Created on 4/25/17.
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "DemoSettings.h"

@implementation DemoSettings

- (instancetype)getLabels:(NSArray *)Carousels {
  NSMutableArray *labels = [NSMutableArray array];
  for (NSDictionary *lbl in Carousels){
    NSLog(@"%@", lbl[@"title"]);
    NSString *tmp = lbl[@"title"];
    
    [labels addObject:tmp];
  }
  return (NSArray *)labels;
}

- (instancetype)initReadJSONFile {
  if (self = [super init]) {
    NSString *path = [NSBundle.mainBundle pathForResource:@"config" ofType:@"json"];
    NSString *configjson = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSError *error = nil;
    NSData *JSONData = [configjson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSONDictonary = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
    
    if (!error && JSONDictonary) {
      for (NSString *key in JSONDictonary) {
        [self setValue:[JSONDictonary valueForKey:key] forKey:key];
      }
    }
  }
  return self;
}

@end
