#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "FTOPlanViewController.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"
#import "UITableViewController+NoEmptyRows.h"
#import "TextViewInputAccessoryBuilder.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"
#import "FTOWorkoutStore.h"

@interface FTOPlanViewController ()
@property(nonatomic) NSDictionary *variantCells;
@end

@implementation FTOPlanViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.trainingMaxField];
    [self.trainingMaxField setDelegate:self];

    self.variantCells = @{
            @"Standard" : self.standardVariant,
            @"Pyramid" : self.pyramidVariant,
            @"Joker" : self.jokerVariant
    };

    [self checkCurrentVariant];
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
    if ([indexPath section] == 1) {
        UITableViewCell *selectedCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        NSString *newVariantName = [self.variantCells detect:^BOOL(id key, UITableViewCell *cell) {
            return cell == selectedCell;
        }];
        FTOVariant *variant = [[FTOVariantStore instance] first];
        variant.name = newVariantName;

        [[FTOWorkoutStore instance] switchTemplate];
        [self checkCurrentVariant];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end