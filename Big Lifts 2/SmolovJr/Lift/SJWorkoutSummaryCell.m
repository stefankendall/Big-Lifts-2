#import "SJWorkoutSummaryCell.h"
#import "SJWorkout.h"
#import "Workout.h"
#import "Set.h"

@implementation SJWorkoutSummaryCell

- (void)awakeFromNib {
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (void)setWorkout:(SJWorkout *)sjWorkout {
    [self.setsLabel setText:[NSString stringWithFormat:@"%d sets", [sjWorkout.workout.sets count]]];
    Set *set = [sjWorkout.workout.sets firstObject];
    [self.repsLabel setText:[NSString stringWithFormat:@"%d reps", [set.reps intValue]]];
    [self.percentageLabel setText:[NSString stringWithFormat:@"%@%%", [set.percentage stringValue]]];

    if ([sjWorkout.maxWeightAdd intValue] > 0) {
        [self.addWeightRangeLabel setText:[NSString stringWithFormat:@"+%@-%@ lbs", sjWorkout.minWeightAdd, sjWorkout.maxWeightAdd]];
    }
    else {
        [self.addWeightRangeLabel setText:@""];
    }
}

@end