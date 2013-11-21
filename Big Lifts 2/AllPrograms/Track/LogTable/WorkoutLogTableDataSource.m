#import "WorkoutLogTableDataSource.h"
#import "WorkoutLog.h"
#import "SetLogCell.h"
#import "LogMaxEstimateCell.h"
#import "SetHelper.h"
#import "OneRepEstimator.h"
#import "SetLog.h"
#import "SettingsStore.h"
#import "Settings.h"

const int SETS_SECTION = 0;
const int ESTIMATED_MAX_SECTION = 1;

@implementation WorkoutLogTableDataSource

- (id)initWithWorkoutLog:(WorkoutLog *)workoutLog1 {
    self = [super init];
    if (self) {
        self.workoutLog = workoutLog1;
    }

    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == SETS_SECTION) {
        return [[self.workoutLog orderedSets] count];
    }
    else {
        return ESTIMATED_MAX_SECTION;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SETS_SECTION) {
        SetLogCell *cell = (SetLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetLogCell.class)];
        if (cell == nil) {
            cell = [SetLogCell create];
        }
        [cell setSetLog:[[self.workoutLog orderedSets] objectAtIndex:(NSUInteger) [indexPath row]]];
        return cell;
    }
    else {
        return [self maxEstimateCell:tableView];
    }
}

- (UITableViewCell *)maxEstimateCell:(UITableView *)tableView {
    LogMaxEstimateCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LogMaxEstimateCell.class)];
    if (!cell) {
        cell = [LogMaxEstimateCell create];
    }
    SetLog *logToShow = [[SetHelper new] heaviestAmrapSetLog:self.workoutLog.orderedSets];
    if (!logToShow) {
        logToShow = [self.workoutLog.orderedSets lastObject];
    }
    NSDecimalNumber *estimate = [[OneRepEstimator new] estimate:logToShow.weight withReps:[logToShow.reps intValue]];
    NSString *units = [[[SettingsStore instance] first] units];
    [cell.maxEstimate setText:[NSString stringWithFormat:@"%@ %@", [estimate stringValue], units]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SET_LOG_CELL_HEIGHT;
}

@end