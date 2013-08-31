#import "SJSetCell.h"
#import "SJWorkout.h"
#import "Set.h"
#import "Lift.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "WeightRounder.h"

@implementation SJSetCell

- (void)setSjWorkout:(SJWorkout *)sjWorkout withSet:(Set *)set {
    [self.liftLabel setText:set.lift.name];
    [self.repsLabel setText:[NSString stringWithFormat:@"%@x", set.reps]];
    [self.percentageLabel setText:[NSString stringWithFormat:@"%@%%", set.percentage]];

    NSDecimalNumber *effectiveWeight = set.effectiveWeight;
    NSString *units = [[[SettingsStore instance] first] units];
    NSLog(@"%@", sjWorkout);
    if ([sjWorkout.minWeightAdd compare:N(0)] == NSOrderedDescending) {
        NSDecimalNumber *minWeight = [effectiveWeight decimalNumberByAdding:sjWorkout.minWeightAdd];
        NSDecimalNumber *maxWeight = [effectiveWeight decimalNumberByAdding:sjWorkout.maxWeightAdd];
        [self.weightRangeLabel setText:[NSString stringWithFormat:@"%@-%@ %@",
                                                                  [[WeightRounder new] round:minWeight],
                                                                  [[WeightRounder new] round:maxWeight],
                                                                  units]];
    } else {
        [self.weightRangeLabel setText:[NSString stringWithFormat:@"%@ %@",
                                                                  [[WeightRounder new] round:effectiveWeight],
                                                                  units]];
    }
}

@end