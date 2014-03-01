#import "FTOFullCustomAssistanceViewController.h"
#import "JFTOAssistance.h"
#import "JFTOAssistanceStore.h"
#import "FTOCustomAssistanceWorkoutViewController.h"
#import "FTOCustomToolbar.h"

@implementation FTOFullCustomAssistanceViewController

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return 0;
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
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomAssistanceLiftGroupCell"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomAssistanceLiftGroupCell"];
//        }
//        JFTOLift *lift = [[JFTOLiftStore instance] atIndex:indexPath.row];
//        [cell.textLabel setText:lift.name];
//        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//
//        return cell;
        return nil;
    }
}

- (void)copyTemplate {
//    [self performSegueWithIdentifier:@"ftoCustomAssistanceCopyTemplate" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoSetupCustomAsstWorkout"]) {
        FTOCustomAssistanceWorkoutViewController *controller = [segue destinationViewController];
        controller.workout = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_FULL_CUSTOM];
}

@end