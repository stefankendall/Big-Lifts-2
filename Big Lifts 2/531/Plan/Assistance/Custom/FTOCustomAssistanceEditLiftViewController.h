#import "BLTableViewController.h"

@class PaddingTextField;
@class JFTOCustomAssistanceLift;

@interface FTOCustomAssistanceEditLiftViewController : BLTableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet PaddingTextField *name;
@property(weak, nonatomic) IBOutlet PaddingTextField *weight;
@property(weak, nonatomic) IBOutlet PaddingTextField *increment;
@property(weak, nonatomic) IBOutlet UISwitch *usesBar;

@property(nonatomic, strong) JFTOCustomAssistanceLift *lift;

- (void)updateLift;
@end