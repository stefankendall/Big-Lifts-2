#import "UITableViewController+NoEmptyRows.h"

@interface SSWorkoutVariantController : UITableViewController {
}
@property(weak, nonatomic) IBOutlet UITableViewCell *onusWunslerCell;
@property(nonatomic, strong) UIView *onusOverlay;

- (void)disableOnusWunsler;

- (void)enable:(UITableViewCell *)cell withOverlay:(UIView *)overlay;
@end