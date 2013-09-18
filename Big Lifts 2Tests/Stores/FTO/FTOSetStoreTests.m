#import "FTOSetStoreTests.h"
#import "FTOSetStore.h"
#import "FTOSet.h"
#import "Lift.h"
#import "FTOLiftStore.h"

@implementation FTOSetStoreTests

- (void)testUsesTrainingMaxToDetermineEffectiveWeight {
    FTOSet *set = [[FTOSetStore instance] create];
    set.lift = [[FTOLiftStore instance] create];
    set.lift.weight = N(200);
    set.percentage = N(50);
    STAssertEqualObjects([set effectiveWeight], N(90), @"");
}

- (void)testDoesNotGoBelowBarWeightWithTrainingMax {
    FTOSet *set = [[FTOSetStore instance] create];
    set.lift = [[FTOLiftStore instance] create];
    set.lift.weight = N(45);
    set.lift.usesBar = YES;
    set.percentage = N(50);
    STAssertEqualObjects([set effectiveWeight], N(45), @"");
}

@end