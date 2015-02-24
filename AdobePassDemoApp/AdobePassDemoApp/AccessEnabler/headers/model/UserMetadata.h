#import <Foundation/Foundation.h>

@interface UserMetadata : NSObject {
    
@private
    NSString *state;
    NSNumber *updated;
    NSMutableDictionary *data;
    NSMutableArray *encrypted;
}

@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSNumber *updated;
@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSMutableArray *encrypted;

- (BOOL)isValid;
- (BOOL)isKeyEncrypted:(NSString*)key;
- (void)merge:(UserMetadata *)userMetadata;

@end
