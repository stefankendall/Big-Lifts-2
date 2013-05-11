#import "SSEditViewController.h"
#import "SSStartingWeightTableDataSource.h"

@implementation SSEditViewController
@synthesize startingWeightTableDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStartingWeightTableDataSource:[[SSStartingWeightTableDataSource alloc] init]];
    [startingWeightTableView setDataSource:startingWeightTableDataSource];
    [ssLiftsTableView setDataSource:startingWeightTableDataSource];
}


@end