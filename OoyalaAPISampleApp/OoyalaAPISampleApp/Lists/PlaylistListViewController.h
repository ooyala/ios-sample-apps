#import <UIKit/UIKit.h>
#import "PlayerSelectionOption.h"

@interface PlaylistListViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) PlayerSelectionOption *option;

@property (nonatomic) BOOL qaModeEnabled;

@end
