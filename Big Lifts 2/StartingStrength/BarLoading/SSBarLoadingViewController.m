#import "SSBarLoadingViewController.h"
#import "WeightsTableDataSource.h"

@implementation SSBarLoadingViewController
@synthesize weightsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    weightsTableDataSource = [WeightsTableDataSource new];
    weightsTableDataSource.tableView = weightsTable;
    [weightsTable setDataSource:weightsTableDataSource];
    [weightsTable setDelegate:weightsTableDataSource];

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleFingerTap setDelegate:self];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [weightsTableDataSource isEditing];
}

- (void)handleSingleTap:(id)handleSingleTap {
    [self.view endEditing:YES];
}


@end