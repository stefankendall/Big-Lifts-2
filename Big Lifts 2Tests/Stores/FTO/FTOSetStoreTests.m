#import "FTOSetStoreTests.h"
#import "FTOSetStore.h"
#import "FTOSet.h"
#import "Lift.h"
#import "SetStore.h"

@implementation FTOSetStoreTests

- (void)testUsesTrainingMaxToDetermineEffectiveWeight {
    FTOSet *set = [[FTOSetStore instance] first];
    set.lift.weight = N(200);
    set.percentage = N(50);
    STAssertEqualObjects([set effectiveWeight], N(90), @"");
}

- (void) testDoesNotGoBelowBarWeightWithTrainingMax {
    FTOSet *set = [[FTOSetStore instance] first];
    set.lift.weight = N(45);
    set.percentage = N(50);
    STAssertEqualObjects([set effectiveWeight], N(45), @"");

}

@end