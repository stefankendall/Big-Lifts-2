#import "SSLogDataSource.h"
#import "CustomTableViewCell.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogStore.h"

@implementation SSLogDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[WorkoutLogStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

    if (cell == nil) {
        cell = [WorkoutLogCell createNewTextCellFromNib];
    }

    return cell;
}

@end