#import "TrackViewController.h"
#import "UITableViewController+NoEmptyRows.h"
#import "FTOSettings.h"

@interface FTOTrackViewController : TrackViewController {}
- (void)viewButtonTapped:(id)sender;

- (NSArray *)getLog;

@property(strong, nonatomic) UIButton *viewButton;
@property(nonatomic) ShowState showState;
@end