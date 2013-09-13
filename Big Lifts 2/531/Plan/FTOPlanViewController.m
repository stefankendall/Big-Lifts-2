#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "FTOPlanViewController.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"
#import "UITableViewController+NoEmptyRows.h"
#import "TextViewInputAccessoryBuilder.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"
#import "Purchaser.h"
#import "PurchaseOverlay.h"

@interface FTOPlanViewController ()
@property(nonatomic) NSDictionary *variantCells;
@property(nonatomic) NSDictionary *iapCells;
@end

@implementation FTOPlanViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.trainingMaxField];
    [self.trainingMaxField setDelegate:self];

    self.variantCells = @{
            FTO_VARIANT_STANDARD : self.standardVariant,
            FTO_VARIANT_PYRAMID : self.pyramidVariant,
            FTO_VARIANT_JOKER : self.jokerVariant,
            FTO_VARIANT_SIX_WEEK : self.sixWeekVariant,
            FTO_VARIANT_FIRST_SET_LAST_MULTIPLE_SETS : self.firstSetLastMultipleSetsVariant,
            FTO_VARIANT_ADVANCED : self.advancedVariant,
            FTO_VARIANT_FIVES_PROGRESSION : self.fivesProgressionVariant
    };

    self.iapCells = @{
            IAP_FTO_JOKER : self.jokerVariant,
            IAP_FTO_ADVANCED : self.advancedVariant,
            IAP_FTO_FIVES_PROGRESSION : self.fivesProgressionVariant
    };

    [self checkCurrentVariant];
    [self enableDisableIapCells];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableDisableIapCells)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)checkCurrentVariant {
    FTOVariant *variant = [[FTOVariantStore instance] first];
    [[self.variantCells allValues] each:^(UITableViewCell *cell) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }];
    [self.variantCells[variant.name] setAccessoryType:UITableViewCellAccessoryCheckmark];
}

- (void)viewWillAppear:(BOOL)animated {
    FTOSettings *settings = [[FTOSettingsStore instance] first];
    [self.trainingMaxField setText:[settings.trainingMax stringValue]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.trainingMaxField == textField) {
        FTOSettings *settings = [[FTOSettingsStore instance] first];
        settings.trainingMax = [NSDecimalNumber decimalNumberWithString:[textField text]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([selectedCell viewWithTag:kPurchaseOverlayTag]) {
        [self purchaseFromCell:selectedCell];
    }
    else if ([indexPath section] == 1) {
        NSString *newVariantName = [self.variantCells detect:^BOOL(id key, UITableViewCell *cell) {
            return cell == selectedCell;
        }];
        [[FTOVariantStore instance] changeTo:newVariantName];
        [self checkCurrentVariant];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end