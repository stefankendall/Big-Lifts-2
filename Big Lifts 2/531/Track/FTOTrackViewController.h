#import "TrackViewController.h"
#import "UITableViewController+NoEmptyRows.h"

@interface FTOTrackViewController : TrackViewController {}
- (void)viewButtonTapped:(id)sender;

@property(strong, nonatomic) UIButton *viewButton;
@end