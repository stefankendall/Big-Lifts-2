#import "FTOCustomAssistanceWorkoutViewController.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "AddCell.h"
#import "JWorkout.h"
#import "FTOCustomAssistanceWorkoutSetCell.h"
#import "JSet.h"
#import "JLift.h"

@implementation FTOCustomAssistanceWorkoutViewController

static const int SETS_SECTION = 0;
static const int ADD_SECTION = 1;

- (void)viewWillAppear:(BOOL)animated {
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
        return [self.customAssistanceWorkout.workout.sets count];
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
        JSet *set = self.customAssistanceWorkout.workout.sets[(NSUInteger) indexPath.row];
        [cell.liftName setText:set.lift.name];
        [cell.reps setText:[set.reps stringValue]];
        [cell.weight setText:[[set effectiveWeight] stringValue]];
        return cell;
    }
}

@end