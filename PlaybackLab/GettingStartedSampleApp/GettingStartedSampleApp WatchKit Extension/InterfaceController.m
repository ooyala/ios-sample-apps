//
//  InterfaceController.m
//  GettingStartedSampleApp WatchKit Extension
//
//  Created by Liusha Huang on 2/19/15.
//
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (strong, nonatomic) IBOutlet WKInterfaceButton *button;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (strong, nonatomic) NSTimer *timer;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
  [super awakeWithContext:context];
  // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (instancetype)init {
  // Always call super first.
  self = [super init];
  return self;
}

- (void)updatePlayheadTime {
  NSString *action = @"playheadUpdate";
  NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[action] forKeys:@[@"action"]];

  //Handle reciever in app delegate of parent app
  [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
    NSLog(@"%@ %@",replyInfo, error);
    NSLog(@"playheadTime = %@", [replyInfo objectForKey:@"playheadTime"]);
    CGFloat playheadTime = [[replyInfo objectForKey:@"playheadTime"] doubleValue];
    [self.label setText:[NSString stringWithFormat:@"playheadTime = %0.0f", playheadTime]];
  }];
}

- (IBAction)play {
  if (self.timer == nil) {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updatePlayheadTime) userInfo:nil repeats:YES];
  }
  //Send count to parent application
  NSString *counterString = @"play";
  NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[counterString] forKeys:@[@"action"]];

  //Handle reciever in app delegate of parent app
  [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
    NSLog(@"%@ %@",replyInfo, error);
  }];
}

- (IBAction)pause {
  [self.timer invalidate];
  self.timer = nil;
  //Send count to parent application
  NSString *counterString = @"pause";
  NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[counterString] forKeys:@[@"action"]];

  //Handle reciever in app delegate of parent app
  [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
    NSLog(@"%@ %@",replyInfo, error);
  }];
}


@end



