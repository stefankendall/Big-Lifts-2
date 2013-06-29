#import "SSLogDataSource.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogStore.h"

@implementation SSLogDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getSsLog] count];
}

- (NSArray *)getSsLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"Starting Strength"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

    if (cell == nil) {
        cell = [WorkoutLogCell create];
        [cell setWorkoutLog:[self getSsLog][(NSUInteger) [indexPath row]]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WorkoutLog *log = [self getSsLog][(NSUInteger) [indexPath row]];
        [[WorkoutLogStore instance] remove:log];
        [tableView reloadData];
    }
}


@end