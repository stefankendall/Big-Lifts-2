#import "UIViewController+PurchaseOverlay.h"

@interface FTOAssistanceViewController : UITableViewController {}
@property (weak, nonatomic) IBOutlet UITableViewCell *noneCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *bbbCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *triumvirateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sstCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *customCell;

@property(nonatomic, copy) NSString *selectedAssitanceType;
@end