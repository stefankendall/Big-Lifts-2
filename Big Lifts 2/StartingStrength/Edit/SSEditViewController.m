#import "SSEditViewController.h"
#import "SSLiftFormDataSource.h"

@implementation SSEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    ssLiftFormDataSource = [SSLiftFormDataSource new];
    [self.tableView setDataSource:ssLiftFormDataSource];
    [self.tableView setDelegate:self];
}

- (void)handleSingleTap:(id)handleSingleTap {
    [self.view endEditing:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end