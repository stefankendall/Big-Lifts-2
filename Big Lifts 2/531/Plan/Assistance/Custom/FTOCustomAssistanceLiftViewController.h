#import "BLTableViewController.h"

@class JFTOCustomAssistanceLift;

@interface FTOCustomAssistanceLiftViewController : BLTableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property(nonatomic, strong) JFTOCustomAssistanceLift *segueLift;
@end