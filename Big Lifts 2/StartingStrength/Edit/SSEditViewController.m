#import <FlurrySDK/Flurry.h>
#import "SSEditViewController.h"
#import "JSSLiftStore.h"
#import "LiftFormCell.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JSSLift.h"
#import "PaddingRowTextField.h"

@implementation SSEditViewController

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"StartingStrength_Edit"];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JSSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiftFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LiftFormCell.class)];
    if (cell == nil) {
        cell = [LiftFormCell create];
    }

    JSSLift *lift = ([[JSSLiftStore instance] findAll])[(NSUInteger) indexPath.row];
    [[cell liftLabel] setText:[lift effectiveName]];

    [[cell textField] setIndexPath:indexPath];
    [[cell textField] setDelegate:self];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:[cell textField]];

    if ([indexPath section] == 0) {
        if ([lift.weight doubleValue] > 0) {
            [[cell textField] setText:[lift.weight stringValue]];
        }
    }
    else {
        [[cell textField] setText:[lift.increment stringValue]];
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"Lifts - current weight" : @"Increment";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    PaddingRowTextField *rowTextField = (PaddingRowTextField *) textField;
    NSIndexPath *indexPath = [rowTextField indexPath];

    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:[textField text] locale:NSLocale.currentLocale];
    JSSLift *lift = [[JSSLiftStore instance] findAll][(NSUInteger) [indexPath row]];
    if ([indexPath section] == 0) {
        [lift setWeight:weight];
    }
    else {
        [lift setIncrement:weight];
    }
}

@end