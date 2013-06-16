#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SSBarLoadingViewController.h"
#import "BarLoadingDataSource.h"
#import "PlateStore.h"
#import "PurchaseOverlayView.h"
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
    PurchaseOverlayView *purchaseOverlayView = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlayView" owner:self options:nil][0];
    [self.view addSubview:purchaseOverlayView];
}

- (void)viewWillAppear:(BOOL)animated {
    [weightsTable reloadData];
    if (([[IAPAdapter instance] hasPurchased:@"barLoading"])) {
        [[self findOverlay] removeFromSuperview];
    }
}

- (UIView *)findOverlay {
    return [[[self view] subviews] detect:^BOOL(UIView *obj) {
        return [obj isKindOfClass:PurchaseOverlayView.class];
    }];
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