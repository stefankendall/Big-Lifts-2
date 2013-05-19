#import "NavTableViewController.h"
#import "NavTableViewCell.h"
#import "IIViewDeckController.h"
#import "NavSetupReturnCell.h"
#import "NavSettingsCell.h"
#import "NavEditCell.h"
#import "NavLiftCell.h"

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
    [self.viewDeckController closeLeftViewAnimated:YES];
    if ([cell isKindOfClass:NavSetupReturnCell.class]) {
        [[self.viewDeckController navigationController] popViewControllerAnimated:YES];
    } else if ([cell isKindOfClass:NavSettingsCell.class]) {
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssSettingsViewController"]];
    } else if ([cell isKindOfClass:NavEditCell.class]){
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssEditViewController"]];
    } else if ([cell isKindOfClass:NavLiftCell.class]){
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssLiftViewController"]];
    }
}


@end