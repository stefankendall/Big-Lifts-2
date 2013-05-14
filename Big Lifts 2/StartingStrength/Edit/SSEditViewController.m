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
    [startingWeightTableDataSource setTableView:startingWeightTableView];

    [ssLiftsTableView setDataSource:liftsTableDataSource];

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(id)handleSingleTap {
    [self.view endEditing:YES];
}


@end