#import "BarLoadingViewController.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "PurchaseOverlay.h"
#import "UIViewController+PurchaseOverlay.h"
#import "WeightTableCell.h"
#import "JSettings.h"
#import "JSettingsStore.h"
#import "BarWeightCell.h"
#import "JBarStore.h"
#import "TextFieldWithCell.h"
#import "RowUIButton.h"
#import "StepperWithCell.h"
#import "AddCell.h"
#import "JBar.h"
#import "JPlateStore.h"
#import "JPlate.h"

@interface BarLoadingViewController ()

@property(nonatomic, strong) UITextField *barWeightTextField;
@end

@implementation BarLoadingViewController

- (void)viewDidLoad {
    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    if (!([[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING])) {
        [self disable:IAP_BAR_LOADING view:self.view withDescription:
                @"In a workout, plates will show below weights.\n"
                "Bench 235lbs\n"
                "[45,45,5]"];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeOverlayIfNecessary)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [self removeOverlayIfNecessary];
}

- (void)removeOverlayIfNecessary {
    if (([[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING])) {
        [self.view removeGestureRecognizer:[self.view.gestureRecognizers lastObject]];
        [[self.tableView viewWithTag:kPurchaseOverlayTag] removeFromSuperview];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [self isEditing] || [self.tableView viewWithTag:kPurchaseOverlayTag] != nil;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tgr {
    if ([self.tableView viewWithTag:kPurchaseOverlayTag]) {
        [[Purchaser new] purchase:IAP_BAR_LOADING];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == [[JPlateStore instance] count]) {
        [self performSegueWithIdentifier:@"barLoadingAddPlateSegue" sender:self];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Bar";
    }
    else {
        return @"Plates";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        int ADD_ROW_COUNT = 1;
        return [[JPlateStore instance] count] + ADD_ROW_COUNT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return [self getBarWeightCell:tableView];
    }
    else {
        return [self getPlateCell:tableView indexPath:indexPath];
    }
}

- (UITableViewCell *)getPlateCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if (row == [[JPlateStore instance] count]) {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        if (cell == nil) {
            cell = [AddCell create];
        }
        return cell;
    }
    else {
        WeightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeightTableCell"];

        if (cell == nil) {
            cell = [WeightTableCell create];
        }

        JPlate *plate = [[JPlateStore instance] atIndex:row];
        JSettings *settings = [[JSettingsStore instance] first];
        [cell.weightLabel setText:[plate.weight stringValue]];
        [cell.unitsLabel setText:settings.units];
        [cell.countLabel setText:[plate.count stringValue]];
        cell.indexPath = indexPath;

        [cell.stepper addTarget:self action:@selector(plateCountChanged:) forControlEvents:UIControlEventValueChanged];
        cell.deleteButton.indexPath = indexPath;
        [cell.deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        [self modifyCellForPlateCount:cell currentPlateCount:[plate.count intValue]];

        return cell;
    }
}

- (void)deleteButtonTapped:(id)deleteButton {
    RowUIButton *button = deleteButton;
    int row = [[button indexPath] row];
    [[JPlateStore instance] removeAtIndex:row];
    [self.tableView reloadData];
}

- (UITableViewCell *)getBarWeightCell:(UITableView *)tableView {
    BarWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BarWeightCell"];

    if (cell == nil ) {
        cell = [BarWeightCell create];
    }

    JBar *bar = [[JBarStore instance] first];
    [[cell textField] setText:[bar.weight stringValue]];
    [[cell textField] setDelegate:self];
    self.barWeightTextField = [cell textField];

    return cell;
}


- (void)plateCountChanged:(UIStepper *)plateStepper {
    StepperWithCell *stepperWithCell = (StepperWithCell *) plateStepper;

    int row = [[[stepperWithCell cell] indexPath] row];
    JPlate *p = [[JPlateStore instance] atIndex:row];

    int additiveCount = (int) [stepperWithCell value];
    int currentPlateCount = [p.count intValue];

    if (additiveCount + currentPlateCount < 0) {
        currentPlateCount = 0;
    }
    else {
        currentPlateCount += additiveCount;
    }

    p.count = [NSNumber numberWithInt:currentPlateCount];

    [self modifyCellForPlateCount:[stepperWithCell cell] currentPlateCount:currentPlateCount];
    [self.tableView reloadData];
}

- (void)modifyCellForPlateCount:(WeightTableCell *)cell currentPlateCount:(int)currentPlateCount {
    UIStepper *plateStepper = [cell stepper];
    [plateStepper setValue:0];

    BOOL atMinimum = currentPlateCount == 0;
    [plateStepper setMinimumValue:(atMinimum ? 0 : -2)];
    [[cell platesLabel] setHidden:atMinimum];
    [[cell countLabel] setHidden:atMinimum];
    [[cell deleteButton] setHidden:!atMinimum];
}


- (BOOL)isEditing {
    return [self.barWeightTextField isEditing];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *newWeight = [textField text];
    JBar *bar = [[JBarStore instance] first];
    bar.weight = [NSDecimalNumber decimalNumberWithString:newWeight locale:NSLocale.currentLocale];
    bar.weight = [bar.weight isEqual:[NSDecimalNumber notANumber]] ? N(0) : bar.weight;
}


@end