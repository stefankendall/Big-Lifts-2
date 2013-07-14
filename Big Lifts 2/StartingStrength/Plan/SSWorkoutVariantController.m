#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "SSWorkoutVariantController.h"
#import "SSWorkoutStore.h"
#import "NSDictionaryMutator.h"
#import "SSVariantStore.h"
#import "SSVariant.h"
#import "IAPAdapter.h"
#import "PurchaseOverlay.h"
#import "Purchaser.h"
#import "SKProductStore.h"
#import "PriceFormatter.h"

@interface SSWorkoutVariantController ()
@property(nonatomic, strong) NSDictionary *variantMapping;
@property(nonatomic, strong) NSDictionary *iapCells;
@end

@implementation SSWorkoutVariantController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.variantMapping = @{@0 : @"Standard", @1 : @"Novice", @2 : @"Onus-Wunsler", @3 : @"Practical Programming"};
    self.iapCells = @{IAP_SS_ONUS_WUNSLER : self.onusWunslerCell,
            IAP_SS_PRACTICAL_PROGRAMMING : self.practicalProgrammingCell};
    [self checkSelectedVariant];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableOrDisableIapCells)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self enableOrDisableIapCells];
}

- (void)enableOrDisableIapCells {
    NSLog(@"%@", self.iapCells);
    [[self.iapCells allKeys] each:^(NSString *purchaseId) {
        if (!([[IAPAdapter instance] hasPurchased:purchaseId])) {
            [self disable:purchaseId];
        }
        else {
            [self enable:purchaseId];
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell viewWithTag:kPurchaseOverlayTag]) {
        NSString *purchaseId = [self.iapCells detect:^BOOL(id key, id obj) {
            return cell == obj;
        }];
        [[Purchaser new] purchase:purchaseId];
    }
    else {
        NSString *variantName = [self.variantMapping objectForKey:[NSNumber numberWithInteger:[indexPath row]]];
        [[SSWorkoutStore instance] setupVariant:variantName];

        [self checkSelectedVariant];
    }
}

- (void)disable:(NSString *)purchaseId {
    UITableViewCell *cell = self.iapCells[purchaseId];
    if (![cell viewWithTag:kPurchaseOverlayTag]) {
        PurchaseOverlay *overlay = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlay" owner:self options:nil][0];
        CGRect frame = CGRectMake(0, 0, [cell frame].size.width, [cell frame].size.height);
        [overlay setFrame:frame];
        SKProduct *product = [[SKProductStore instance] productById:purchaseId];
        [overlay.price setText:[[PriceFormatter new] priceOf:product]];
        [cell addSubview:overlay];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

- (void)enable:(NSString *)purchaseId {
    UITableViewCell *cell = self.iapCells[purchaseId];
    if ([cell viewWithTag:kPurchaseOverlayTag]) {
        UIView *overlay = [cell viewWithTag:kPurchaseOverlayTag];
        [overlay removeFromSuperview];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
}

- (void)checkSelectedVariant {
    SSVariant *variant = [[SSVariantStore instance] first];
    [self uncheckAllRows];

    int index = [[[NSDictionaryMutator new] invert:self.variantMapping][variant.name] intValue];
    UITableViewCell *cell = [self tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [[cell viewWithTag:1] setHidden:NO];
}

- (void)uncheckAllRows {
    for (int i = 0; i < [self tableView:nil numberOfRowsInSection:0]; i++) {
        UITableViewCell *cell = [self tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [[cell viewWithTag:1] setHidden:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end