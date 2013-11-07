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
    return [[self.workoutLog orderedSets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetLogCell.class)];

    if (cell == nil) {
        cell = [SetLogCell create];
    }
    [cell setSetLog:[[self.workoutLog orderedSets] objectAtIndex:(NSUInteger) [indexPath row]]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SET_LOG_CELL_HEIGHT;
}

@end