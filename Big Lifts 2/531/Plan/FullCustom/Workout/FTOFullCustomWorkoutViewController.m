#import "FTOFullCustomWorkoutViewController.h"
#import "JFTOFullCustomWorkout.h"
#import "JWorkout.h"
#import "AddCell.h"
#import "FTOFullCustomSetCell.h"
#import "JLift.h"
#import "JFTOLift.h"
#import "JFTOFullCustomWeek.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOSetStore.h"
#import "JFTOSet.h"

@implementation FTOFullCustomWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    JFTOFullCustomWeek *week = [[JFTOFullCustomWeekStore instance] weekContaining: self.customWorkout];
    NSString *title = [NSString stringWithFormat:@"%@, %@", week.name, self.customWorkout.lift.name];
    [self setTitle:title];
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

        [cell setSet: self.customWorkout.workout.sets[(NSUInteger) indexPath.row]];
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
        NSLog(@"Transition");
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

@end