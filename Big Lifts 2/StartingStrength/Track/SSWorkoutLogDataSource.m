#import "SSWorkoutLogDataSource.h"
#import "WorkoutLog.h"
#import "SetLogCell.h"
#import "SetLogCombiner.h"
#import "LogCellWithSets.h"

@implementation SSWorkoutLogDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getCombinedSets] count];
}

- (NSArray *)getCombinedSets {
    return [[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:self.workoutLog.orderedSets]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LogCellWithSets *cell = (LogCellWithSets *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LogCellWithSets.class)];

    if (cell == nil) {
        cell = [LogCellWithSets create];
    }
    [cell setSetLogContainer:[self getCombinedSets][(NSUInteger) [indexPath row]]];
    return cell;
}

@end