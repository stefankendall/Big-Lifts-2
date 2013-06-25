#import <ViewDeck/IIViewDeckController.h>
#import "BLNavController.h"
#import "NavTableViewCell.h"

@implementation BLNavController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < ([[self tableView] numberOfRowsInSection:0]); i++) {
        UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([cell isKindOfClass:NavTableViewCell.class]) {
            [(NavTableViewCell *) cell setRightMargin:(int) [self.viewDeckController rightLedgeSize]];
        }
    }
}

@end