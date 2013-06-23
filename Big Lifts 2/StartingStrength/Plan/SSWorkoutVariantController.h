#import "UITableViewController+NoEmptyRows.h"

@interface SSWorkoutVariantController : UITableViewController
{}
@property (weak, nonatomic) IBOutlet UITableViewCell *onusWunslerCell;

- (void)disableOnusWunsler;

- (void)enableOnusWunsler;
@end