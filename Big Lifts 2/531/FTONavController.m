#import <ViewDeck/IIViewDeckController.h>
#import "FTONavController.h"

@implementation FTONavController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController closeLeftViewAnimated:YES];

    NSDictionary *tagViewMapping = @{
            @0 : @"ftoLiftNav",
            @1 : @"ftoEditNavController",
            @2 : @"barLoadingNav",
            @3 : @"ftoTrackNavController",
            @4 : @"settingsViewController",
            @7 : @"ftoPlanNav",
    };

    if ([cell tag] == 6) {
        [[self.viewDeckController navigationController] popViewControllerAnimated:YES];
    } else if ([cell tag] == 8){
        [self presentFeedbackEmail];
    } else {
        NSString *storyBoardId = [tagViewMapping objectForKey:[NSNumber numberWithInteger:[cell tag]]];
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:storyBoardId]];
    }
}

@end