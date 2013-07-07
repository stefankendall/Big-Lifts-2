#import "SetLogTests.h"
#import "SetLog.h"
#import "SetLogStore.h"
#import "SetLogContainer.h"

@implementation SetLogTests

- (void)testIsEqualSameValues {
    SetLog *log1 = [[SetLogStore instance] create];
    log1.name = @"Squat";
    log1.reps = @5;
    log1.weight = N(255.5);

    SetLog *log2 = [[SetLogStore instance] create];
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
    SetLog *log1 = [[SetLogStore instance] create];
    log1.name = @"Squat";
    log1.reps = @4;
    log1.weight = N(255.5);

    SetLog *log2 = [[SetLogStore instance] create];
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