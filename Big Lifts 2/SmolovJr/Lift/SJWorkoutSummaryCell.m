#import "SJWorkoutSummaryCell.h"
#import "Workout.h"
#import "JSet.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "JSJWorkout.h"
#import "JWorkout.h"

@implementation SJWorkoutSummaryCell

- (void)awakeFromNib {
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (void)setWorkout:(JSJWorkout *)sjWorkout {
    [self.setsLabel setText:[NSString stringWithFormat:@"%d sets", [sjWorkout.workout.orderedSets count]]];
    JSet *set = [sjWorkout.workout.orderedSets firstObject];
    [self.repsLabel setText:[NSString stringWithFormat:@"%d reps", [set.reps intValue]]];
    [self.percentageLabel setText:[NSString stringWithFormat:@"%@%%", [set.percentage stringValue]]];

    if ([sjWorkout.maxWeightAdd intValue] > 0) {
        [self.addWeightRangeLabel setText:[NSString stringWithFormat:@"+%@-%@ %@", sjWorkout.minWeightAdd, sjWorkout.maxWeightAdd,
                                                                     [[[JSettingsStore instance] first] units]]];
    }
    else {
        [self.addWeightRangeLabel setText:@""];
    }

    if (sjWorkout.done) {
        [self setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
}

@end