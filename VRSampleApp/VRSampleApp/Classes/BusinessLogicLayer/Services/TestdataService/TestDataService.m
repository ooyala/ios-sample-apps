//
//  TestDataService.m
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "TestDataService.h"
#import "VideoItemSection+Mappable.h"


@implementation TestDataService

#pragma mark - TestDataServiceProtocol

- (NSArray *)obtainTestData {
  NSString *pathToTestDataJSON = [NSBundle.mainBundle pathForResource:@"data" ofType:@"json"];
  
  if (!pathToTestDataJSON) {
    return NULL;
  }
  
  NSURL *urlToTestDataJSON = [NSURL fileURLWithPath:pathToTestDataJSON];
  NSData *jsonData = [NSData dataWithContentsOfURL:urlToTestDataJSON];
  
  if (!jsonData) {
    return NULL;
  }
  
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                       options:NSJSONReadingAllowFragments
                                                         error:&error];
  
  return [VideoItemSection createCollectionFromJSON:json];
}


@end
