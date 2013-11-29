#import "FTOWorkoutLogWorkSetsDataSource.h"
#import "SetLogCell.h"
#import "JWorkoutLog.h"

@implementation FTOWorkoutLogWorkSetsDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == SETS_SECTION) {
        return [[self.workoutLog workSets] count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SETS_SECTION) {
        SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetLogCell.class)];
        if (cell == nil) {
            cell = [SetLogCell create];
        }
        [cell setSetLog:[self.workoutLog workSets][(NSUInteger) [indexPath row]]];
        return cell;
    }
    else {
        return [self maxEstimateCell: tableView];
    }
}

@end