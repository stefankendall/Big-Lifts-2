#import "TrackViewController.h"
#import "UITableViewController+NoEmptyRows.h"
#import "JFTOSettings.h"

@interface FTOTrackViewController : TrackViewController {}
- (void)sortButtonTapped:(id)sortButtonTapped;

- (void)viewButtonTapped:(id)sender;

- (NSArray *)getLog;

@property(nonatomic) ShowState showState;
@property(nonatomic) TrackSort trackSort;
@end