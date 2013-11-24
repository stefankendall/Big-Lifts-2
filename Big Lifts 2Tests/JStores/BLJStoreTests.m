#import "BLJStoreTests.h"
#import "FTOLiftJStore.h"
#import "JFTOLift.h"

@implementation BLJStoreTests

- (void)setUp {
    [super setUp];
    [[FTOLiftJStore instance] empty];
}

- (void)testCreate {
    JFTOLift *lift = [[FTOLiftJStore instance] create];
    STAssertNotNil(lift, @"");
}

- (void)testCount {
    [[FTOLiftJStore instance] create];
    [[FTOLiftJStore instance] create];
    STAssertEquals([[FTOLiftJStore instance] count], 2, @"");
}

- (void)testEmpty {
    [[FTOLiftJStore instance] create];
    [[FTOLiftJStore instance] empty];
    STAssertEquals([[FTOLiftJStore instance] count], 0, @"");
}

- (void)testFirstLast {
    JFTOLift *lift1 = [[FTOLiftJStore instance] create];
    lift1.order = @0;
    JFTOLift *lift3 = [[FTOLiftJStore instance] create];
    lift3.order = @2;
    JFTOLift *lift2 = [[FTOLiftJStore instance] create];
    lift2.order = @1;

    STAssertEquals([[FTOLiftJStore instance] first], lift1, @"");
    STAssertEquals([[FTOLiftJStore instance] last], lift3, @"");
}

- (void)testFindByNameValue {
    JFTOLift *lift1 = [[FTOLiftJStore instance] create];
    lift1.name = @"A";
    JFTOLift *lift2 = [[FTOLiftJStore instance] create];
    lift2.name = @"B";
    JFTOLift *lift3 = [[FTOLiftJStore instance] create];
    lift3.name = @"C";

    STAssertEquals([[FTOLiftJStore instance] find:@"name" value:@"B"], lift2, @"");
}

- (void)testFindAll {
    JFTOLift *lift1 = [[FTOLiftJStore instance] create];
    lift1.name = @"A";
    JFTOLift *lift2 = [[FTOLiftJStore instance] create];
    lift2.name = @"B";

    NSArray *expected = @[lift1, lift2];
    STAssertEqualObjects([[FTOLiftJStore instance] findAll], expected, @"");
}

- (void)testSync {
    JFTOLift *lift1 = [[FTOLiftJStore instance] create];
    lift1.name = @"A";
    lift1.increment = N(5.5);
    lift1.usesBar = YES;
    lift1.weight = N(100);
    lift1.order = nil;

    [[FTOLiftJStore instance] sync];
    [[FTOLiftJStore instance] empty];
    [[FTOLiftJStore instance] load];

    JFTOLift *syncedLift = [[FTOLiftJStore instance] first];
    STAssertEqualObjects(syncedLift.name, @"A", @"");
    STAssertEqualObjects(syncedLift.increment, N(5.5), @"");
    STAssertEquals(syncedLift.usesBar, YES, @"");
    STAssertEqualObjects(syncedLift.weight, N(100), @"");
    STAssertEquals(syncedLift.order, nil, @"");
}

@end