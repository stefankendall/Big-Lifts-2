#import <FlurrySDK/Flurry.h>
#import "FTOFullCustomWorkoutViewController.h"
#import "JFTOFullCustomWorkout.h"
#import "JWorkout.h"
#import "AddCell.h"
#import "FTOFullCustomSetCell.h"
#import "JLift.h"
#import "JFTOLift.h"
#import "JSet.h"
#import "JFTOFullCustomWeek.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOSetStore.h"
#import "JFTOSet.h"
#import "FTOFullCustomSetEditor.h"

@implementation FTOFullCustomWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"5/3/1_FullCustom_Workout"];

    JFTOFullCustomWeek *week = [[JFTOFullCustomWeekStore instance] weekContaining:self.customWorkout];
    NSString *title = [NSString stringWithFormat:@"%@, %@", week.name, self.customWorkout.lift.name];
    [self setTitle:title];

    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.customWorkout.workout.sets count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FTOFullCustomSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOFullCustomSetCell.class)];
        if (!cell) {
            cell = [FTOFullCustomSetCell create];
        }

        [cell setSet:self.customWorkout.workout.sets[(NSUInteger) indexPath.row]];
        return cell;
    }
    else {
        AddCell *addCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        if (!addCell) {
            addCell = [AddCell create];
        }

        return addCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.tappedSet = self.customWorkout.workout.sets[(NSUInteger) indexPath.row];
        [self performSegueWithIdentifier:@"ftoFullCustomSetSelected" sender:self];
    }
    else {
        JFTOSet *newSet = [[JFTOSetStore instance] create];
        newSet.lift = self.customWorkout.lift;
        newSet.reps = N(0);
        newSet.percentage = N(100);
        newSet.amrap = NO;
        newSet.warmup = NO;
        [self.customWorkout.workout addSet:newSet];
        [self.tableView reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoFullCustomSetSelected"]) {
        FTOFullCustomSetEditor *editor = [segue destinationViewController];
        [editor setSet:self.tappedSet];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.customWorkout.workout removeSet:self.customWorkout.workout.sets[(NSUInteger) indexPath.row]];
    [self.tableView reloadData];
}

- (IBAction)deleteButtonTapped:(id)sender {
    [self.tableView setEditing:!self.tableView.editing];
    if (self.tableView.editing) {
        [self.deleteButton setTitle:@"Done"];
    }
    else {
        [self.deleteButton setTitle:@"Delete"];
    }
}

@end