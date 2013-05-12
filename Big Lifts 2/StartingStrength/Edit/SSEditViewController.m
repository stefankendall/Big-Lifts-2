#import "SSEditViewController.h"
#import "SSStartingWeightTableDataSource.h"
#import "SSLiftsTableDataSource.h"

@implementation SSEditViewController
@synthesize startingWeightTableDataSource, liftsTableDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStartingWeightTableDataSource:[[SSStartingWeightTableDataSource alloc] init]];
    [self setLiftsTableDataSource:[[SSLiftsTableDataSource alloc] init]];
    [startingWeightTableView setDataSource:startingWeightTableDataSource];
    [ssLiftsTableView setDataSource:liftsTableDataSource];
}


@end