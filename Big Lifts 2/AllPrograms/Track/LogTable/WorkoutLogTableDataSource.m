#import "WorkoutLogTableDataSource.h"
#import "WorkoutLog.h"
#import "SetLogCell.h"
#import "SetLogCombiner.h"

@implementation WorkoutLogTableDataSource

- (id)initWithWorkoutLog:(WorkoutLog *)workoutLog1 {
    self = [super init];
    if (self) {
        self.workoutLog = workoutLog1;
    }

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getCombinedSets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetLogCell.class)];

    if (cell == nil) {
        cell = [SetLogCell create];
    }
    [cell setSetLogContainer:[[self getCombinedSets] objectAtIndex:(NSUInteger) [indexPath row]]];

    return cell;
}

- (NSArray *)getCombinedSets {
    return [[SetLogCombiner new] combineSetLogs:self.workoutLog.sets];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SET_LOG_CELL_HEIGHT;
}

@end