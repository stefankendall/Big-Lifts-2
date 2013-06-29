#import "SSNavTableViewController.h"
#import "IIViewDeckController.h"

@implementation SSNavTableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController closeLeftViewAnimated:YES];

    NSDictionary *tagViewMapping = @{
            @4 : @"ssSettingsViewController",
            @1 : @"ssEditViewController",
            @2 : @"ssBarLoading",
            @0 : @"ssLiftViewController",
            @3 : @"ssTrackViewController",
            @5 : @"purchasesController",
            @7 : @"ssPlanWorkoutsNav",
    };

    if ([cell tag] == 6) {
        [[self.viewDeckController navigationController] popViewControllerAnimated:YES];
    } else {
        NSString *storyBoardId = [tagViewMapping objectForKey:[NSNumber numberWithInteger:[cell tag]]];
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:storyBoardId]];
    }
}

@end