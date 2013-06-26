#import "FTOEditViewController.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "LiftFormCell.h"
#import "TextFieldWithCell.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTOEditViewController

- (void)viewDidLoad {
    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(id)handleSingleTap {
    [self.view endEditing:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiftFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LiftFormCell.class)];
    if (cell == nil) {
        cell = [LiftFormCell create];
    }

    FTOLift *lift = ([[FTOLiftStore instance] findAll])[(NSUInteger) indexPath.row];
    [[cell liftLabel] setText:lift.name];

    [cell setIndexPath:indexPath];
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


@end