#import "SSBarLoadingViewController.h"
#import "WeightsTableDataSource.h"
#import "PlateStore.h"

@implementation SSBarLoadingViewController
@synthesize weightsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    weightsTableDataSource = [WeightsTableDataSource new];
    weightsTableDataSource.tableView = weightsTable;
    [weightsTable setDataSource:weightsTableDataSource];
    [weightsTable setDelegate:self];

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleFingerTap setDelegate:self];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)viewWillAppear:(BOOL)animated {
    [weightsTable reloadData];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [weightsTableDataSource isEditing];
}

- (void)handleSingleTap:(id)handleSingleTap {
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == [[PlateStore instance] count]) {
        [self performSegueWithIdentifier:@"barLoadingAddPlateSegue" sender:self];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}


@end