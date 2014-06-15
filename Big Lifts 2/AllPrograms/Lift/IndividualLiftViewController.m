#import "IndividualLiftViewController.h"
#import "RestShareToolbar.h"
#import "BLTimer.h"
#import "JWorkout.h"

@implementation IndividualLiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib:RestShareToolbar.class];
}

- (void)viewWillAppear:(BOOL)animated {
    [[BLTimer instance] setObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[BLTimer instance] setObserver:nil];
}

- (void)timerTick {
    [self.tableView reloadRowsAtIndexPaths:@[NSIP(0, 0)] withRowAnimation:UITableViewRowAnimationNone];
}

- (RestShareToolbar *)restToolbar:(UITableView *)tableView {
    RestShareToolbar *toolbar = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RestShareToolbar.class)];
    [toolbar updateTime];
    [toolbar.timerButton addTarget:self action:@selector(goToTimer) forControlEvents:UIControlEventTouchUpInside];
    [toolbar setShareDelegate:self];
    return toolbar;
}

- (NSArray *)getSharedWorkout {
    [NSException raise:@"Must implement" format:@""];
}

@end