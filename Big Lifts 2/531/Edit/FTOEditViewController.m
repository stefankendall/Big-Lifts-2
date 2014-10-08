#import <FlurrySDK/Flurry.h>
#import "FTOEditViewController.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "FTOEditLiftCell.h"
#import "RowTextField.h"
#import "TextViewInputAccessoryBuilder.h"
#import "TrainingMaxRowTextField.h"
#import "JFTOSettingsStore.h"
#import "FTOEditIncrementCell.h"
#import "JFTOSettings.h"
#import "DecimalNumberHandlers.h"

@implementation FTOEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib:FTOEditIncrementCell.class];
    [self registerCellNib:FTOEditLiftCell.class];
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"5/3/1_Edit"];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JFTOLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFTOLift *lift = (JFTOLift *) [self liftAtIndex:[indexPath row]];
    if ([indexPath section] == 0) {
        FTOEditLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOEditLiftCell.class)];

        [cell setLift:lift];
        [[cell max] setIndexPath:indexPath];
        [[cell trainingMax] setIndexPath:indexPath];
        [[cell max] setDelegate:self];
        [[cell trainingMax] setDelegate:self];
        return cell;
    }
    else {
        return [self incrementCell:self.tableView indexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 1 ? @"Increment" : @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"FTOEditMaxesHeader" owner:self options:nil][0];
        CGRect bounds = [view bounds];
        [view setBounds:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width,
                [self tableView:nil heightForHeaderInSection:section])];
        return view;
    }

    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    RowTextField *rowTextField = (RowTextField *) textField;
    NSIndexPath *indexPath = [rowTextField indexPath];
    JLift *lift = [self liftAtIndex:[indexPath row]];

    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:[textField text] locale:NSLocale.currentLocale];
    weight = [weight isEqual:[NSDecimalNumber notANumber]] ? N(0) : weight;

    if ([indexPath section] == 1) {
        [lift setIncrement:weight];
    }
    else {
        if ([textField isKindOfClass:TrainingMaxRowTextField.class]) {
            JFTOSettings *ftoSettings = [[JFTOSettingsStore instance] first];
            NSDecimalNumber *trainingMaxFraction = [N(100) decimalNumberByDividingBy:[ftoSettings trainingMax] withBehavior:DecimalNumberHandlers.noRaise];
            NSDecimalNumber *max =
                    [trainingMaxFraction decimalNumberByMultiplyingBy:weight withBehavior:DecimalNumberHandlers.noRaise];
            NSNumberFormatter *nf = [NSNumberFormatter new];
            [nf setMaximumFractionDigits:1];
            NSString *oneDecimalMax = [nf stringFromNumber:max];
            [lift setWeight:[NSDecimalNumber decimalNumberWithString:oneDecimalMax locale:NSLocale.currentLocale]];
        }
        else {
            [lift setWeight:weight];
        }
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (UITableViewCell *)incrementCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    JLift *lift = [self liftAtIndex:[indexPath row]];
    FTOEditIncrementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOEditIncrementCell.class)];

    [[cell liftLabel] setText:lift.name];
    [[cell increment] setText:[lift.increment stringValue]];
    [[cell increment] setDelegate:self];
    [cell increment].indexPath = indexPath;
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:[cell increment]];
    return cell;
}

- (JLift *)liftAtIndex:(int)index {
    return [[JFTOLiftStore instance] atIndex:index];
}

@end