#import "FTOWorkoutLogAmrapDataSource.h"
#import "SetLogCell.h"
#import "SetHelper.h"
#import "JSetLog.h"
#import "JWorkoutLog.h"

@implementation FTOWorkoutLogAmrapDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SETS_SECTION) {
        SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetLogCell.class)];
        if (cell == nil) {
            cell = [SetLogCell create];
        }
        JSetLog *logToShow = [SetHelper heaviestAmrapSetLog:self.workoutLog.workSets];
        if (!logToShow) {
            logToShow = [[self.workoutLog workSets] lastObject];
        }
        [cell setSetLog:logToShow];
        return cell;
    }
    else {
        if (self.workoutLog.deload) {
            return [self deloadCell:tableView];
        }
        else {
            return [self maxEstimateCell:tableView];
        }
    }
}

@end