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

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(id)handleSingleTap {
    [self.view endEditing:YES];
}


@end