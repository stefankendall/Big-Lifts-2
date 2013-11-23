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
    STAssertEquals([[FTOLiftJStore instance] count], 1, @"");
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

    NSArray *expected = @[lift1,lift2];
    STAssertEqualObjects([[FTOLiftJStore instance] findAll], expected, @"");
}


@end