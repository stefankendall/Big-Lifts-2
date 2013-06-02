#import "SSBarLoadingViewController.h"
#import "WeightsTableDataSource.h"

@implementation SSBarLoadingViewController
@synthesize weightsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    weightsTableDataSource = [WeightsTableDataSource new];
    weightsTableDataSource.onDataChange = ^{
        [weightsTable reloadData];
    };
    [weightsTable setDataSource:weightsTableDataSource];
    [weightsTable setDelegate:weightsTableDataSource];
}


@end