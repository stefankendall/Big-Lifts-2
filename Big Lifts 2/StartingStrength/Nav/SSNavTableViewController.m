#import "SSNavTableViewController.h"
#import "IIViewDeckController.h"

@implementation SSNavTableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController closeLeftViewAnimated:YES];

    NSDictionary *tagViewMapping = @{
            @4 : @"settingsViewController",
            @1 : @"ssEditViewController",
            @2 : @"barLoadingNav",
            @0 : @"ssLiftViewController",
            @3 : @"ssTrackViewController",
            @7 : @"ssPlanWorkoutsNav",
    };

    if ([cell tag] == 6) {
        [[self.viewDeckController navigationController] popViewControllerAnimated:YES];
    } else if([cell tag] == 8){
        [self presentFeedbackEmail];
    } else {
        NSString *storyBoardId = [tagViewMapping objectForKey:[NSNumber numberWithInteger:[cell tag]]];
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:storyBoardId]];
    }
}

@end