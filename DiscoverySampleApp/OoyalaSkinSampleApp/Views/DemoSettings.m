//
//  DemoSettings.m
//  OoyalaSkinSampleApp
//
//  Created by Alan Garcia on 4/25/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "DemoSettings.h"


@implementation DemoSettings


- (instancetype) getLabels: (NSArray *) Carousels
{
  
  NSMutableArray *labels = [[NSMutableArray alloc] init];
  for (NSDictionary *lbl in Carousels){
    
    NSLog(@"%@", [lbl objectForKey:@"title"]);
    NSString *tmp = [lbl objectForKey:@"title"];
    
    [labels addObject:tmp];
  }
  return (NSArray *)labels;
}

- (instancetype) initReadJSONFile
{
  self = [super init];
  if(self){
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    NSString *configjson = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSError *error = nil;
    NSData *JSONData = [configjson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSONDictonary = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
    
    if(!error && JSONDictonary){
      
      for(NSString* key in JSONDictonary){
        [self setValue:[JSONDictonary valueForKey:key] forKey:key];
      }
    }
  
  
  }
  return self;
}






@end
