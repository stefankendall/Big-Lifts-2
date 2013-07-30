#import "BarLoadingViewController.h"
#import "BarLoadingDataSource.h"
#import "PlateStore.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "PurchaseOverlay.h"
#import "UIViewController+PurchaseOverlay.h"

@implementation BarLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    weightsTableDataSource = [BarLoadingDataSource new];
    weightsTableDataSource.tableView = self.tableView;
    [self.tableView setDataSource:weightsTableDataSource];
    [self.tableView setDelegate:self];

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    if (!([[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING])) {
        [self disable:IAP_BAR_LOADING view:self.view];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeOverlayIfNecessary)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [self removeOverlayIfNecessary];
}

- (void)removeOverlayIfNecessary {
    if (([[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING])) {
        [self.view removeGestureRecognizer:[self.view.gestureRecognizers lastObject]];
        [[self.tableView viewWithTag:kPurchaseOverlayTag] removeFromSuperview];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [weightsTableDataSource isEditing] || [self.tableView viewWithTag:kPurchaseOverlayTag] != nil;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tgr {
    if ([self.tableView viewWithTag:kPurchaseOverlayTag]) {
        [[Purchaser new] purchase:IAP_BAR_LOADING];
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