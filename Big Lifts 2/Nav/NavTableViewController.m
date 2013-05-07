#import "NavTableViewController.h"
#import "NavTableViewCell.h"
#import "IIViewDeckController.h"
#import "NavSetupReturnCell.h"
#import "NavSettingsCell.h"

@implementation NavTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < ([[self tableView] numberOfRowsInSection:0]); i++) {
        UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([cell isKindOfClass:NavTableViewCell.class]) {
            [(NavTableViewCell *) cell setRightMargin:(int) [self.viewDeckController rightLedgeSize]];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    if ([cell isKindOfClass:NavSetupReturnCell.class]) {
        [[self.viewDeckController navigationController] popViewControllerAnimated:YES];
    } else if ([cell isKindOfClass:NavSettingsCell.class]) {
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssSettingsViewController"]];
        [self.viewDeckController closeLeftViewAnimated:YES];
    }


}


@end