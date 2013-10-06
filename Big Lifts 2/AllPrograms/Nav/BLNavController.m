#import <ViewDeck/IIViewDeckController.h>
#import "BLNavController.h"
#import "NavTableViewCell.h"
#import "Mailer.h"
#import "CurrentProgramStore.h"
#import "CurrentProgram.h"

@implementation BLNavController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < ([[self tableView] numberOfRowsInSection:0]); i++) {
        UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([cell isKindOfClass:NavTableViewCell.class]) {
            [(NavTableViewCell *) cell setRightMargin:(int) [self.viewDeckController leftSize]];
        }
    }
}

- (void)presentFeedbackEmail {
    [[[Mailer alloc] initWithSender:self] presentFeedback];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController closeLeftViewAnimated:YES];

    NSMutableDictionary *tagViewMapping = [[self specificTagMapping] mutableCopy];
    tagViewMapping[@2] = @"barLoadingNav";
    tagViewMapping[@4] = @"settingsViewController";
    tagViewMapping[@9] = @"likeNav";
    tagViewMapping[@10] = @"oneRepNav";

    if ([cell tag] == 6) {
        [[[CurrentProgramStore instance] first] setName: nil];
        [[self.viewDeckController navigationController] popViewControllerAnimated:YES];
    } else if ([cell tag] == 8) {
        [self presentFeedbackEmail];
    } else {
        NSString *storyBoardId = [tagViewMapping objectForKey:[NSNumber numberWithInteger:[cell tag]]];
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:storyBoardId]];
    }
}

- (NSDictionary *)specificTagMapping {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end