#import "FTORepsToBeatBreakdown.h"
#import "FTORepsToBeatCalculator.h"
#import "Set.h"
#import "OneRepEstimator.h"
#import "Lift.h"

@implementation FTORepsToBeatBreakdown

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.enteredOneRepMax setText:[self.lastSet.lift.weight stringValue]];
    NSDecimalNumber *logMax = [[FTORepsToBeatCalculator new] findLogMax:self.lastSet.lift];
    [self.maxFromLog setText:[logMax stringValue]];

    NSDecimalNumber *lastSetWeight = [self.lastSet roundedEffectiveWeight];
    int minimumReps = [[FTORepsToBeatCalculator new] repsToBeat:self.lastSet.lift atWeight:lastSetWeight];
    [self.reps setText:[NSString stringWithFormat:@"%dx", minimumReps]];
    [self.weight setText:[lastSetWeight stringValue]];

    NSDecimalNumber *estimatedMax = [[OneRepEstimator new] estimate:lastSetWeight withReps:minimumReps];
    [self.estimatedMax setText:[estimatedMax stringValue]];
}


@end