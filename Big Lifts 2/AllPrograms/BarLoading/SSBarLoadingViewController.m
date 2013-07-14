#import "SSBarLoadingViewController.h"
#import "BarLoadingDataSource.h"
#import "PlateStore.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "PurchaseOverlay.h"
#import "SKProductStore.h"
#import "PriceFormatter.h"

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

    if (!([[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING])) {
        [self addDisabledView];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeOverlayIfNecessary)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)addDisabledView {
    self.overlay = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlay" owner:self options:nil][0];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.overlay setFrame:frame];
    SKProduct *product = [[SKProductStore instance] productById:IAP_BAR_LOADING];
    [self.overlay.price setText:[[PriceFormatter new] priceOf:product]];
    [self.view addSubview:self.overlay];
}

- (void)viewWillAppear:(BOOL)animated {
    [weightsTable reloadData];
    [self removeOverlayIfNecessary];
}

- (void)removeOverlayIfNecessary {
    if (([[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING])) {
        [self.overlay removeFromSuperview];
        self.overlay = nil;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [weightsTableDataSource isEditing] || self.overlay != nil;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tgr {
    if (self.overlay) {
        [[Purchaser new] purchase:IAP_BAR_LOADING];
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