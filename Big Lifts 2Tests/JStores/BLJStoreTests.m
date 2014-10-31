#import "BLJStoreTests.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"

@implementation BLJStoreTests

- (void)setUp {
    [super setUp];
    [[JFTOLiftStore instance] empty];
    [[JFTOLiftStore instance] sync];
}

- (void)testNoKey {
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    NSArray *array = [keyValueStore arrayForKey:@"BADKEY"];
    STAssertEqualObjects(array, nil, @"");
}

- (void)testCreate {
    JFTOLift *lift = [[JFTOLiftStore instance] create];
    STAssertNotNil(lift, @"");
}

- (void)testCount {
    [[JFTOLiftStore instance] create];
    [[JFTOLiftStore instance] create];
    STAssertEquals([[JFTOLiftStore instance] count], 2, @"");
}

- (void)testEmpty {
    [[JFTOLiftStore instance] create];
    [[JFTOLiftStore instance] empty];
    STAssertEquals([[JFTOLiftStore instance] count], 0, @"");
}

- (void)testFirstLast {
    JFTOLift *lift1 = [[JFTOLiftStore instance] create];
    lift1.order = @0;
    JFTOLift *lift3 = [[JFTOLiftStore instance] create];
    lift3.order = @2;
    JFTOLift *lift2 = [[JFTOLiftStore instance] create];
    lift2.order = @1;

    STAssertEquals([[JFTOLiftStore instance] first], lift1, @"");
    STAssertEquals([[JFTOLiftStore instance] last], lift3, @"");
}

- (void)testFindByNameValue {
    JFTOLift *lift1 = [[JFTOLiftStore instance] create];
    lift1.name = @"A";
    JFTOLift *lift2 = [[JFTOLiftStore instance] create];
    lift2.name = @"B";
    JFTOLift *lift3 = [[JFTOLiftStore instance] create];
    lift3.name = @"C";

    STAssertEquals([[JFTOLiftStore instance] find:@"name" value:@"B"], lift2, @"");
}

- (void)testFindAll {
    JFTOLift *lift1 = [[JFTOLiftStore instance] create];
    lift1.name = @"A";
    JFTOLift *lift2 = [[JFTOLiftStore instance] create];
    lift2.name = @"B";

    NSArray *expected = @[lift1, lift2];
    STAssertEqualObjects([[JFTOLiftStore instance] findAll], expected, @"");
}

- (void)testSerialize {
    JFTOLift *lift1 = [[JFTOLiftStore instance] create];
    lift1.name = @"A";
    lift1.increment = N(5.5);
    lift1.usesBar = YES;
    lift1.weight = N(100);
    lift1.order = @0;

    NSArray *serialized = [[JFTOLiftStore instance] serializeAndCache];
    STAssertNotNil(serialized, @"");
}

- (void)testSync {
    [[JFTOLiftStore instance] clearSyncCache];
    JFTOLift *lift1 = [[JFTOLiftStore instance] create];
    lift1.name = @"A";
    lift1.increment = N(5.5);
    lift1.usesBar = YES;
    lift1.weight = N(100);
    lift1.order = @1;

    [[JFTOLiftStore instance] sync];
    [[JFTOLiftStore instance] empty];
    [[JFTOLiftStore instance] load:nil];

    JFTOLift *syncedLift = [[JFTOLiftStore instance] first];
    STAssertEqualObjects(syncedLift.name, @"A", @"");
    STAssertEqualObjects(syncedLift.increment, N(5.5), @"");
    STAssertEquals(syncedLift.usesBar, YES, @"");
    STAssertEqualObjects(syncedLift.weight, N(100), @"");
}

@end