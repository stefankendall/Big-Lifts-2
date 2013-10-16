#import "FTOWorkoutLogWorkSetsDataSource.h"
#import "SetLogCell.h"
#import "WorkoutLog.h"
#import "SetLogContainer.h"
#import "SetLogCombiner.h"

@implementation FTOWorkoutLogWorkSetsDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getCombinedSetLogs] count];
}

- (NSArray *)getCombinedSetLogs {
    return [[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:[self.workoutLog workSets]]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetLogCell.class)];

    if (cell == nil) {
        cell = [SetLogCell create];
    }
    [cell setSetLogContainer:[self getCombinedSetLogs][(NSUInteger) [indexPath row]]];
    return cell;
}

@end