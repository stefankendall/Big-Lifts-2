#import "SJSetCellWithPlates.h"
#import "JSJWorkout.h"
#import "JSet.h"
#import "BarCalculator.h"
#import "JBarStore.h"
#import "JBar.h"
#import "JPlateStore.h"

@implementation SJSetCellWithPlates

- (void)setSjWorkout:(JSJWorkout *)sjWorkout withSet:(JSet *)set withEnteredWeight:(NSDecimalNumber *)weight {
    [super setSjWorkout:sjWorkout withSet:set withEnteredWeight:weight];
    JBar *bar = [[JBarStore instance] first];
    BarCalculator *calculator = [[BarCalculator alloc] initWithPlates:[[JPlateStore instance] findAll]
                                                            barWeight:bar.weight];

    NSArray *plates = [calculator platesToMakeWeight:[set roundedEffectiveWeight]];
    NSString *platesText = @"";
    if ([plates count] != 0) {
        platesText = [NSString stringWithFormat:@"[%@]", [plates componentsJoinedByString:@", "]];
    }

    [self.platesLabel setText:platesText];
}


@end