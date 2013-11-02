#import "SJSetCellWithPlates.h"
#import "SJWorkout.h"
#import "Set.h"
#import "PlateStore.h"
#import "BarCalculator.h"
#import "BarStore.h"
#import "Bar.h"

@implementation SJSetCellWithPlates

- (void)setSjWorkout:(SJWorkout *)sjWorkout withSet:(Set *)set withEnteredWeight:(NSDecimalNumber *)weight {
    [super setSjWorkout:sjWorkout withSet:set withEnteredWeight:weight];
    Bar *bar = [[BarStore instance] first];
    BarCalculator *calculator = [[BarCalculator alloc] initWithPlates:[[PlateStore instance] findAll]
                                                            barWeight:bar.weight];

    NSArray *plates = [calculator platesToMakeWeight:[set roundedEffectiveWeight]];
    NSString *platesText = @"";
    if ([plates count] != 0) {
        platesText = [NSString stringWithFormat:@"[%@]", [plates componentsJoinedByString:@", "]];
    }

    [self.platesLabel setText:platesText];
}


@end