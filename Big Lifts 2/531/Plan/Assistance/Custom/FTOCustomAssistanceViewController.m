#import "FTOCustomAssistanceViewController.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "FTOCustomAssistanceWorkoutViewController.h"
#import "JFTOCustomAssistanceWorkoutStore.h"

@implementation FTOCustomAssistanceViewController

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Assistance for lift";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JFTOLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomAssistanceLiftGroupCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomAssistanceLiftGroupCell"];
    }
    JFTOLift *lift = [[JFTOLiftStore instance] atIndex:indexPath.row];
    [cell.textLabel setText:lift.name];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
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

@end