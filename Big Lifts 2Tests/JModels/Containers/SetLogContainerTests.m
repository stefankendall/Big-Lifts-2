#import "SetLogContainerTests.h"
#import "JSetLogStore.h"
#import "JSetLog.h"
#import "SetLogContainer.h"

@implementation SetLogContainerTests

- (void)testIsEqualSameValues {
    JSetLog *log1 = [[JSetLogStore instance] create];
    log1.name = @"Squat";
    log1.reps = @5;
    log1.weight = N(255.5);

    JSetLog *log2 = [[JSetLogStore instance] create];
    log2.name = @"Squat";
    log2.reps = @5;
    log2.weight = N(255.5);

    SetLogContainer *container1 = [SetLogContainer new];
    container1.setLog = log1;
    SetLogContainer *container2 = [SetLogContainer new];
    container2.setLog = log2;

    STAssertTrue([container1 isEqual:container2], @"");
}

- (void)testIsEqualDifferentValues {
    JSetLog *log1 = [[JSetLogStore instance] create];
    log1.name = @"Squat";
    log1.reps = @4;
    log1.weight = N(255.5);

    JSetLog *log2 = [[JSetLogStore instance] create];
    log2.name = @"Squat";
    log2.reps = @5;
    log2.weight = N(255.5);

    SetLogContainer *container1 = [SetLogContainer new];
    container1.setLog = log1;
    SetLogContainer *container2 = [SetLogContainer new];
    container2.setLog = log2;

    STAssertFalse([container1 isEqual:container2], @"");
}

@end