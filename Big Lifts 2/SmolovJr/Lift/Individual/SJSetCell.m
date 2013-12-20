#import "SJSetCell.h"
#import "JSJWorkout.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "WeightRounder.h"
#import "JSet.h"
#import "JLift.h"
#import "DecimalNumberHandlers.h"

@implementation SJSetCell

- (void)setSjWorkout:(JSJWorkout *)sjWorkout withSet:(JSet *)set withEnteredWeight:(NSDecimalNumber *)enteredWeight {
    [self.liftLabel setText:set.lift.name];
    [self.repsLabel setText:[NSString stringWithFormat:@"%@x", set.reps]];
    [self.percentageLabel setText:[NSString stringWithFormat:@"%@%%", set.percentage]];


    NSDecimalNumber *effectiveWeight = set.effectiveWeight;
    NSString *units = [[[JSettingsStore instance] first] units];
    if (enteredWeight) {
        [self.weightRangeLabel setText:[NSString stringWithFormat:@"%@ %@",
                                                                  enteredWeight,
                                                                  units]];
    } else if ([sjWorkout.minWeightAdd compare:N(0)] == NSOrderedDescending) {
        NSDecimalNumber *minWeight = [effectiveWeight decimalNumberByAdding:sjWorkout.minWeightAdd withBehavior:DecimalNumberHandlers.noRaise];
        NSDecimalNumber *maxWeight = [effectiveWeight decimalNumberByAdding:sjWorkout.maxWeightAdd withBehavior:DecimalNumberHandlers.noRaise];
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