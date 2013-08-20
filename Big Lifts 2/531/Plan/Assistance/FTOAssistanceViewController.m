#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "FTOAssistanceViewController.h"
#import "FTOAssistance.h"
#import "FTOAssistanceStore.h"
#import "UITableViewController+NoEmptyRows.h"
#import "Purchaser.h"
#import "PurchaseOverlay.h"
#import "IAPAdapter.h"

@interface FTOAssistanceViewController ()
@property(nonatomic, strong) NSDictionary *cellMapping;
@property(nonatomic, strong) NSDictionary *iapCells;
@end

@implementation FTOAssistanceViewController

- (void)viewDidLoad {
    self.cellMapping = @{
            FTO_ASSISTANCE_NONE : self.noneCell,
            FTO_ASSISTANCE_BORING_BUT_BIG : self.bbbCell,
            FTO_ASSISTANCE_TRIUMVIRATE : self.triumvirateCell
    };

    self.iapCells = @{
            IAP_FTO_TRIUMVIRATE : self.triumvirateCell
    };

    [self enableDisableIapCells];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableDisableIapCells)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self checkCurrentAssistance];
}

- (void)checkCurrentAssistance {
    [[self.cellMapping allValues] each:^(UITableViewCell *cell) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }];
    NSString *name = [[[FTOAssistanceStore instance] first] name];
    [self.cellMapping[name] setAccessoryType:UITableViewCellAccessoryCheckmark];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([selectedCell viewWithTag:kPurchaseOverlayTag]) {
        [self purchaseFromCell:selectedCell];
    }
    else {
        NSString *assistanceType = [self.cellMapping detect:^BOOL(NSString *type, UITableViewCell *cell) {
            return selectedCell == cell;
        }];
        [[FTOAssistanceStore instance] changeTo:assistanceType];
        [self checkCurrentAssistance];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if([identifier isEqualToString:@"ftoTriumvirate"] && ![[IAPAdapter instance] hasPurchased:IAP_FTO_TRIUMVIRATE]){
        return NO;
    }
    return YES;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end