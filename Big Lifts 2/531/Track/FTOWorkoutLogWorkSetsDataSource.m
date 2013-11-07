#import "FTOWorkoutLogWorkSetsDataSource.h"
#import "SetLogCell.h"
#import "WorkoutLog.h"

@implementation FTOWorkoutLogWorkSetsDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.workoutLog workSets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetLogCell.class)];

    if (cell == nil) {
        cell = [SetLogCell create];
    }
    [cell setSetLog:[self.workoutLog workSets][(NSUInteger) [indexPath row]]];
    return cell;
}

@end