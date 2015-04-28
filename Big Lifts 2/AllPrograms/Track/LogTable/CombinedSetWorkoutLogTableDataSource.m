#import "WorkoutLogTableDataSource.h"
#import "SetLogCell.h"
#import "SetLogCombiner.h"
#import "LogCellWithSets.h"
#import "CombinedSetWorkoutLogTableDataSource.h"
#import "JWorkoutLog.h"

@implementation CombinedSetWorkoutLogTableDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getCombinedSets] count];
}

- (NSArray *)getCombinedSets {
    return [[SetLogCombiner new] combineSetLogs:self.workoutLog.workSets];
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