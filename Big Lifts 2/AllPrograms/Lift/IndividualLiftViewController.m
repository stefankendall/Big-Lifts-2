#import "IndividualLiftViewController.h"
#import "RestToolbar.h"
#import "BLTimer.h"

@implementation IndividualLiftViewController

- (void)viewWillAppear:(BOOL)animated {
    [[BLTimer instance] setObserver:self];
}

- (void)timerTick {
    [self.tableView reloadRowsAtIndexPaths:@[NSIP(0, 0)] withRowAnimation:UITableViewRowAnimationNone];
}

- (RestToolbar *)restToolbar:(UITableView *)tableView {
    RestToolbar *toolbar = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RestToolbar.class)];

    if (!toolbar) {
        toolbar = [RestToolbar create];
    }

    [toolbar updateTime];
    [toolbar.timerButton addTarget:self action:@selector(goToTimer) forControlEvents:UIControlEventTouchUpInside];

    return toolbar;
}

@end