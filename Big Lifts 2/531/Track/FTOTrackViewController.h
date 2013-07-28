#import "TrackViewController.h"
#import "UITableViewController+NoEmptyRows.h"

@interface FTOTrackViewController : TrackViewController {}
- (void)viewButtonTapped:(id)sender;

- (NSArray *)getLog;

@property(strong, nonatomic) UIButton *viewButton;
@end