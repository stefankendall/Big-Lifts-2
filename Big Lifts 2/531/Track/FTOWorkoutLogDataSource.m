#import "FTOWorkoutLogDataSource.h"
#import "SetLogCell.h"
#import "WorkoutLog.h"
#import "SetLogContainer.h"
#import "SetLog.h"

@implementation FTOWorkoutLogDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.workoutLog workSets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:@"SetLogCell"];

    if (cell == nil) {
        cell = [SetLogCell create];
        SetLog *setLog = [self.workoutLog workSets][(NSUInteger) [indexPath row]];
        SetLogContainer *container = [[SetLogContainer alloc] initWithSetLog:setLog];
        container.count = 1;
        [cell setSetLogContainer:container];
    }

    return cell;
}

@end