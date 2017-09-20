//
//  OOQueuedEvent.h
//  OoyalaSkinSDK
//

#import <Foundation/Foundation.h>

@interface OOQueuedEvent : NSObject

@property (nonatomic) NSString *eventName;
@property (nonatomic) id body;

- (instancetype)initWithWithName:(NSString *)eventName body:(id)body;

@end
