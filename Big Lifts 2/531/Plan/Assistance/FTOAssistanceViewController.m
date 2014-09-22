#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import <FlurrySDK/Flurry.h>
#import "FTOAssistanceViewController.h"
#import "Purchaser.h"
#import "PurchaseOverlay.h"
#import "IAPAdapter.h"
#import "JFTOAssistanceStore.h"
#import "JFTOAssistance.h"

@interface FTOAssistanceViewController ()
@property(nonatomic, strong) NSDictionary *cellMapping;
@property(nonatomic, strong) NSDictionary *iapCells;
@property(nonatomic, strong) NSDictionary *assistanceToSegues;
@end

@implementation FTOAssistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellMapping = @{
            FTO_ASSISTANCE_NONE : self.noneCell,
            FTO_ASSISTANCE_BORING_BUT_BIG : self.bbbCell,
            FTO_ASSISTANCE_TRIUMVIRATE : self.triumvirateCell,
            FTO_ASSISTANCE_SST : self.sstCell,
            FTO_ASSISTANCE_CUSTOM : self.customCell,
            FTO_ASSISTANCE_FULL_CUSTOM : self.fullCustom
    };

    self.iapCells = @{
            IAP_FTO_TRIUMVIRATE : self.triumvirateCell,
            IAP_FTO_SST : self.sstCell,
            IAP_FTO_FULL_CUSTOM_ASSISTANCE : self.fullCustom
    };

    self.assistanceToSegues = @{
            FTO_ASSISTANCE_TRIUMVIRATE : @"ftoTriumvirate",
            FTO_ASSISTANCE_SST : @"ftoSst",
            FTO_ASSISTANCE_FULL_CUSTOM : @"ftoFullCustomAssistance"
    };

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(somethingPurchased)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"5/3/1_Assistance"];
    [self enableDisableIapCells];
    [self checkCurrentAssistance];
}

- (void)somethingPurchased {
    if (self.isViewLoaded && self.view.window) {
        [self enableDisableIapCells];
    }
}

- (UIView *)cellStillHasPurchaseOverlay:(UITableViewCell *)cell {
    return [cell viewWithTag:kPurchaseOverlayTag];
}

- (void)checkCurrentAssistance {
    [[self.cellMapping allValues] each:^(UITableViewCell *cell) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }];
    NSString *name = [[[JFTOAssistanceStore instance] first] name];
    [self.cellMapping[name] setAccessoryType:UITableViewCellAccessoryCheckmark];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *assistanceType = [self.cellMapping detect:^BOOL(NSString *type, UITableViewCell *cell) {
        return selectedCell == cell;
    }];
    if ([selectedCell viewWithTag:kPurchaseOverlayTag]) {
        self.selectedAssitanceType = assistanceType;
    }
    else {
        [[JFTOAssistanceStore instance] changeTo:assistanceType];
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