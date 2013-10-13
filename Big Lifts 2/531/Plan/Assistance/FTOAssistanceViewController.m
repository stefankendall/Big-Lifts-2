#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "FTOAssistanceViewController.h"
#import "FTOAssistance.h"
#import "FTOAssistanceStore.h"
#import "Purchaser.h"
#import "PurchaseOverlay.h"
#import "IAPAdapter.h"

@interface FTOAssistanceViewController ()
@property(nonatomic, strong) NSDictionary *cellMapping;
@property(nonatomic, strong) NSDictionary *iapCells;
@property(nonatomic, strong) NSDictionary *assistanceToSegues;
@property(nonatomic, strong) NSIndexPath *iapIndexPath;
@end

@implementation FTOAssistanceViewController

- (void)viewDidLoad {
    self.cellMapping = @{
            FTO_ASSISTANCE_NONE : self.noneCell,
            FTO_ASSISTANCE_BORING_BUT_BIG : self.bbbCell,
            FTO_ASSISTANCE_TRIUMVIRATE : self.triumvirateCell,
            FTO_ASSISTANCE_SST : self.sstCell
    };

    self.iapCells = @{
            IAP_FTO_TRIUMVIRATE : self.triumvirateCell,
            IAP_FTO_SST : self.sstCell
    };

    self.assistanceToSegues = @{
            FTO_ASSISTANCE_TRIUMVIRATE : @"ftoTriumvirate",
            FTO_ASSISTANCE_SST : @"ftoSst"
    };

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(somethingPurchased)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self enableDisableIapCells];
    [self checkCurrentAssistance];
}

- (void)somethingPurchased {
    if (self.isViewLoaded && self.view.window) {
        [self enableDisableIapCells];
        if (self.iapIndexPath) {
            [self tableView:self.tableView didSelectRowAtIndexPath:self.iapIndexPath];
            self.iapIndexPath = nil;
            [self performSegueWithIdentifier:self.assistanceToSegues[
                    [[[FTOAssistanceStore instance] first] name]
            ]                         sender:self];
        }
    }
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
        self.iapIndexPath = indexPath;
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
    NSArray *iaps = [self.iapCells allKeys];
    if ([iaps containsObject:identifier] && ![[IAPAdapter instance] hasPurchased:identifier]) {
        return NO;
    }
    return YES;
}

@end