#import "FTOCustomAssistanceLiftViewController.h"
#import "AddCell.h"
#import "FTOCustomAssistanceLiftCell.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation FTOCustomAssistanceLiftViewController

const int LIFTS_SECTION = 0;
const int ADD_SECTION = 1;

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == LIFTS_SECTION) {
        return [[JFTOCustomAssistanceLiftStore instance] count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ADD_SECTION) {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        if (!cell) {
            cell = [AddCell create];
        }
        return cell;
    }
    else {
        FTOCustomAssistanceLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomAssistanceLiftCell.class)];
        if (!cell) {
            cell = [FTOCustomAssistanceLiftCell create];
        }
        JFTOCustomAssistanceLift *lift = [[JFTOCustomAssistanceLiftStore instance] atIndex:indexPath.row];
        [cell.name setText:lift.name];
        [cell.weight setText:[NSString stringWithFormat:@"%@ %@", lift.weight ? lift.weight : @"0", [[[JSettingsStore instance] first] units]]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ADD_SECTION) {
        self.segueLift = [[JFTOCustomAssistanceLiftStore instance] create];
        self.segueLift.name = @"New Lift";
    }
    else {
        self.segueLift = [[JFTOCustomAssistanceLiftStore instance] atIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:@"ftoCustomAsstEditLift" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOCustomAssistanceEditLiftViewController *controller = [segue destinationViewController];
    controller.lift = self.segueLift;
}


@end