@class FTOWorkoutCell;
@class EverythingDialog;

@interface BLTableViewController : UITableViewController

@property(nonatomic, strong) EverythingDialog *everythingDialog;

- (void)registerCellNib:(Class)klass;

@end