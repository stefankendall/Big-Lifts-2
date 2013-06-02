#import "SSBarLoadingViewController.h"
#import "WeightsTableDataSource.h"

@implementation SSBarLoadingViewController
@synthesize weightsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    weightsTableDataSource = [WeightsTableDataSource new];
    [weightsTable setDataSource:weightsTableDataSource];
    [weightsTable setDelegate:weightsTableDataSource];
}


@end