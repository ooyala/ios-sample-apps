#import <Foundation/Foundation.h>
#import "MVPD.h"

@interface Requestor : NSObject {
    
@private
    NSString *requestorId;
    NSString *signedRequestorId;
    NSString *requestorName;
    NSMutableArray *mvpds;
    BOOL isValid;
}

@property (nonatomic, retain) NSString *requestorId;
@property (nonatomic, retain) NSString *signedRequestorId;
@property (nonatomic, retain) NSString *requestorName;
@property (nonatomic, retain) NSMutableArray *mvpds;
@property (nonatomic, assign) BOOL isValid; 

- (void)initWithRequestor:(Requestor *)requestor;

- (BOOL) isMvpdValid:(NSString *)mvpdId;
- (MVPD *)getMvpdForId:(NSString *)mvpdId;

@end
