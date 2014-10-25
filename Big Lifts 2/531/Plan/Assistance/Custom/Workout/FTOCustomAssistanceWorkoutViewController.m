#import <FlurrySDK/Flurry.h>
#import <Crashlytics/Crashlytics.h>
#import "FTOCustomAssistanceWorkoutViewController.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "AddCell.h"
#import "JWorkout.h"
#import "FTOCustomAssistanceWorkoutSetCell.h"
#import "JSet.h"
#import "JLift.h"
#import "JSetStore.h"
#import "FTOCustomAssistanceEditSetViewController.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation FTOCustomAssistanceWorkoutViewController

static const int SETS_SECTION = 0;
static const int ADD_SECTION = 1;

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"5/3/1_CustomAssistance"];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == ADD_SECTION) {
        return 1;
    }
    else {
        return [self.workout.sets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ADD_SECTION) {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        if (!cell) {
            cell = [AddCell create];
        }
        [cell.addText setText:@"Add Set..."];
        return cell;
    }
    else {
        FTOCustomAssistanceWorkoutSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomAssistanceWorkoutSetCell.class)];
        if (!cell) {
            cell = [FTOCustomAssistanceWorkoutSetCell create];
        }
        JSet *set = self.workout.sets[(NSUInteger) indexPath.row];
        if (set.lift) {
            [cell.liftName setText:set.lift.name];
        }
        else {
            [cell.liftName setText:@"No lift"];
        }

        [cell.reps setText:[NSString stringWithFormat:@"%dx", [set.reps intValue]]];
        [cell.weight setText:[NSString stringWithFormat:@"%@%@", [set effectiveWeight], [[[JSettingsStore instance] first] units]]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ADD_SECTION) {
        self.tappedSet = nil;
    }
    else {
        self.tappedSet = self.workout.sets[(NSUInteger) indexPath.row];
    }

    [self performSegueWithIdentifier:@"ftoCustomAsstEditSet" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CLS_LOG(@"%@", segue.identifier);
    if ([segue.identifier isEqualToString:@"ftoCustomAsstEditSet"]) {
        FTOCustomAssistanceEditSetViewController *controller = [segue destinationViewController];
        controller.workout = self.workout;
        if (self.tappedSet) {
            controller.set = self.tappedSet;
        }
        else {
            JSet *set = [[JSetStore instance] create];
            [self.workout addSet:set];
            controller.set = set;
        }
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"ftoCustomAsstEditSet"] && self.tappedSet != nil && [self.tappedSet isDead]){
        return NO;
    }
    return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
}


- (IBAction)deleteTapped:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [self.deleteButton setTitle:@"Edit Sets"];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        [self.deleteButton setTitle:@"Done"];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ADD_SECTION) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        JSet *set = self.workout.sets[(NSUInteger) indexPath.row];
        [self.workout removeSet:set];
        [self.tableView reloadData];
    }
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)from
       toIndexPath:(NSIndexPath *)to {
    if ([self.workout.sets count] > 1) {
        JSet *sourceSet = self.workout.sets[(NSUInteger) from.row];
        [self.workout.sets removeObjectAtIndex:(NSUInteger) from.row];
        [self.workout.sets insertObject:sourceSet atIndex:(NSUInteger) to.row];
    }
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section != ADD_SECTION;
}

@end