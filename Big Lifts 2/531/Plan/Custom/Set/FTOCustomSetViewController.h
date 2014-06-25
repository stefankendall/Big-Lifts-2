@class JSet;

#import "BLTableViewController.h"

@interface FTOCustomSetViewController : BLTableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *repsLabel;
@property(weak, nonatomic) IBOutlet UITextField *percentageLabel;
@property(weak, nonatomic) IBOutlet UISwitch *amrapSwitch;
@property(weak, nonatomic) IBOutlet UISwitch *warmupSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *optionalSwitch;

@property(nonatomic, strong) JSet *set;
@end