#import "SetLogCellTests.h"
#import "SetLogCell.h"
#import "SetLogContainer.h"
#import "SetLogStore.h"
#import "SetLog.h"

@implementation SetLogCellTests

- (void)testNegativeReps {
    SetLogCell *cell = [SetLogCell create];
    SetLog *setLog = [[SetLogStore instance] create];
    setLog.reps = @-1;
    SetLogContainer *container = [[SetLogContainer alloc] initWithSetLog:setLog];
    [cell setSetLogContainer:container];

    STAssertEqualObjects([[cell repsLabel] text], @"", @"");
}

@end