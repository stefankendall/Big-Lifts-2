#import "BarCalculatorTests.h"
#import "BarCalculator.h"
#import "PlateStore.h"
#import "BLStoreManager.h"
#import "PlateRemaining.h"

@interface BarCalculatorTests ()
@property(nonatomic) BarCalculator *calculator;
@end

@implementation BarCalculatorTests

- (void)setUp {
    [super setUp];
    self.calculator = [[BarCalculator alloc] initWithPlates:[[PlateStore instance] findAll] barWeight:45];
}

- (void)testMakesSimpleWeight {
    NSArray *expected225 = @[@45.0, @45.0];
    STAssertEqualObjects([self.calculator platesToMakeWeight:225], expected225, @"");

    NSArray *expected260 = @[@45.0, @45.0, @10.0, @5, @2.5];
    STAssertEqualObjects([self.calculator platesToMakeWeight:260], expected260, @"");
}

- (void)testCopyPlatesReturnsNewPlates {
    NSArray *copy = [self.calculator copyPlates:[[PlateStore instance] findAll]];
    STAssertEquals((int) [copy count], [[PlateStore instance] count], @"");
    STAssertTrue([copy[0] isKindOfClass:PlateRemaining.class], @"");
}

- (void)testFindPlateClosestToWeightMatch {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:45 count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:35 count:6];
    NSArray *plates = @[
            plate45,
            plate35
    ];

    PlateRemaining *p = [self.calculator findPlateClosestToWeight:100 fromPlates:plates];
    STAssertEquals(p, plate45, @"");
}

- (void)testFindPlateClosestToWeightMatchBelowTop {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:45 count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:35 count:6];
    PlateRemaining *plate25 = [[PlateRemaining alloc] initWithWeight:25 count:6];
    NSArray *plates = @[
            plate45,
            plate35,
            plate25
    ];

    PlateRemaining *p = [self.calculator findPlateClosestToWeight:60 fromPlates:plates];
    STAssertEquals(p, plate25, @"");
}

- (void)testFindPlateClosestToWeightNoMatch {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:45 count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:35 count:6];
    NSArray *plates = @[
            plate45,
            plate35
    ];

    PlateRemaining *p = [self.calculator findPlateClosestToWeight:25 fromPlates:plates];
    STAssertNil(p, @"");
}

@end