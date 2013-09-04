#import "SetTests.h"
#import "Set.h"
#import "SetStore.h"
#import "FTOLiftStore.h"
#import "Lift.h"
#import "FTOSet.h"
#import "FTOSetStore.h"

@implementation SetTests

- (void) testRoundsSpecificWeightCorrectly {
    FTOSet *set = [[FTOSetStore instance] create];
    set.lift = [[FTOLiftStore instance] first];
    set.lift.weight = N(135);
    set.percentage = N(70);
    STAssertEqualObjects([set roundedEffectiveWeight], N(85), @"");
}

@end