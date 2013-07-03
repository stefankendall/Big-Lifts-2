#import "FTOWorkoutLogDataSource.h"
#import "SetLogCell.h"
#import "WorkoutLog.h"
#import "SetLogContainer.h"

@implementation FTOWorkoutLogDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:@"SetLogCell"];

    if (cell == nil) {
        cell = [SetLogCell create];
        SetLog *setLog = [self.workoutLog.sets lastObject];
        [cell setSetLogContainer:[[SetLogContainer alloc] initWithSetLog:setLog]];
    }

    return cell;
}
@end