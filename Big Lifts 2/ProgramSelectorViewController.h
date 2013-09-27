#import "UITableViewController+NoEmptyRows.h"

@interface ProgramSelectorViewController : UITableViewController {
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
}
- (IBAction)unitsChanged:(id)sender;

- (void)rememberSelectedProgram:(NSString *)segueName;

@end