//
//  PlayerSingleButtonOutlet.h
//  
//
//

#import <UIKit/UIKit.h>
#import "PlayerSelectionOption.h"

@interface SampleAppPlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@property (strong, nonatomic) PlayerSelectionOption *playerSelectionOption;

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption;
@end

