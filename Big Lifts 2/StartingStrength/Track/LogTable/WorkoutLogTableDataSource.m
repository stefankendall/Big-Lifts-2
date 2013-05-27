#import "WorkoutLogTableDataSource.h"
#import "WorkoutLog.h"
#import "CustomTableViewCell.h"
#import "SetLogCell.h"

@implementation WorkoutLogTableDataSource
@synthesize workoutLog;

- (id)initWithWorkoutLog:(WorkoutLog *)workoutLog1 {
    self = [super init];
    if (self) {
        workoutLog = workoutLog1;
    }

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[workoutLog sets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:@"SetLogCell"];

    if (cell == nil) {
        cell = [SetLogCell createNewTextCellFromNib];
        [cell setSet:[workoutLog.sets objectAtIndex:(NSUInteger) [indexPath row]]];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SET_LOG_CELL_HEIGHT;
}


@end