#import "FTOCustomAssistanceViewController.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "FTOCustomAssistanceWorkoutViewController.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOAssistanceStore.h"
#import "JFTOAssistance.h"
#import "FTOCustomToolbar.h"

@implementation FTOCustomAssistanceViewController

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    }
    else {
        return @"Assistance for lift";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return [[JFTOLiftStore instance] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FTOCustomToolbar *toolbar = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomToolbar.class)];
        if (!toolbar) {
            toolbar = [FTOCustomToolbar create];
        }
        [toolbar.templateButton addTarget:self action:@selector(copyTemplate) forControlEvents:UIControlEventTouchUpInside];
        return toolbar;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomAssistanceLiftGroupCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomAssistanceLiftGroupCell"];
        }
        JFTOLift *lift = [[JFTOLiftStore instance] atIndex:indexPath.row];
        [cell.textLabel setText:lift.name];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

        return cell;
    }
}

- (void)copyTemplate {
    [self performSegueWithIdentifier:@"ftoCustomAssistanceCopyTemplate" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JFTOLift *lift = [[JFTOLiftStore instance] atIndex:indexPath.row];
    self.customAssistanceToSegue = [[JFTOCustomAssistanceWorkoutStore instance] find:@"mainLift" value:lift];
    [self performSegueWithIdentifier:@"ftoSetupCustomAsstWorkout" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoSetupCustomAsstWorkout"]) {
        FTOCustomAssistanceWorkoutViewController *controller = [segue destinationViewController];
        controller.customAssistanceWorkout = self.customAssistanceToSegue;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_CUSTOM];
}

@end