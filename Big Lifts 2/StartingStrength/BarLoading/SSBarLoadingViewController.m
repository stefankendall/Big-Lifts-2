#import <ViewDeck/IIViewDeckController.h>
#import "SSBarLoadingViewController.h"
#import "BarLoadingDataSource.h"
#import "PlateStore.h"
#import "IAPAdapter.h"

@implementation SSBarLoadingViewController
@synthesize weightsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    weightsTableDataSource = [BarLoadingDataSource new];
    weightsTableDataSource.tableView = weightsTable;
    [weightsTable setDataSource:weightsTableDataSource];
    [weightsTable setDelegate:self];

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    if (!([[IAPAdapter instance] hasPurchased:@"barLoading"])) {
        [self addDisabledView];
    }
}

- (void)addDisabledView {
    self.overlay = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlay" owner:self options:nil][0];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.overlay setFrame:frame];
    [self.view addSubview:self.overlay];
}

- (void)viewWillAppear:(BOOL)animated {
    [weightsTable reloadData];
    if (([[IAPAdapter instance] hasPurchased:@"barLoading"])) {
        [self.overlay removeFromSuperview];
        self.overlay = nil;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [weightsTableDataSource isEditing] || self.overlay != nil;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tgr {
    if (self.overlay) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"purchasesController"]];
    }
    else {
        [self.view endEditing:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == [[PlateStore instance] count]) {
        [self performSegueWithIdentifier:@"barLoadingAddPlateSegue" sender:self];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end