#import "FTOWorkoutLogAmrapDataSource.h"
#import "SetLogCell.h"
#import "SetLogContainer.h"
#import "SetHelper.h"
#import "WorkoutLog.h"

@implementation FTOWorkoutLogAmrapDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == SETS_SECTION){
        SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetLogCell.class)];
        if (cell == nil) {
            cell = [SetLogCell create];
        }
        SetLog *logToShow = [[SetHelper new] heaviestAmrapSetLog:self.workoutLog.orderedSets];
        if (!logToShow) {
            logToShow = [self.workoutLog.orderedSets lastObject];
        }
        [cell setSetLog:logToShow];
        return cell;
    }
    else {
        return [self maxEstimateCell: tableView];
    }
}

@end