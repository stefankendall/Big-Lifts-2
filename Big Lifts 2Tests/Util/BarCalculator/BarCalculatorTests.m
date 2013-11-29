#import "BarCalculatorTests.h"
#import "BarCalculator.h"
#import "PlateRemaining.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "JBarStore.h"
#import "JPlateStore.h"

@interface BarCalculatorTests ()
@property(nonatomic) BarCalculator *calculator;
@end

@implementation BarCalculatorTests

- (void)setUp {
    [super setUp];
    self.calculator = [[BarCalculator alloc] initWithPlates:[[JPlateStore instance] findAll] barWeight:N(45)];
}

- (void)testMakesSimpleWeight {
    NSArray *expected225 = @[@45.0, @45.0];
    STAssertEqualObjects([self.calculator platesToMakeWeight:N(225)], expected225, @"");

    NSArray *expected260 = @[@45.0, @45.0, @10.0, @5, @2.5];
    STAssertEqualObjects([self.calculator platesToMakeWeight:N(260)], expected260, @"");
}

- (void)testCopyPlatesReturnsNewPlates {
    NSArray *copy = [self.calculator copyPlates:[[JPlateStore instance] findAll]];
    STAssertEquals((int) [copy count], [[JPlateStore instance] count], @"");
    STAssertTrue([copy[0] isKindOfClass:PlateRemaining.class], @"");
}

- (void)testCalculates70kg {
    [[[SettingsStore instance] first] setUnits:@"kg"];
    [[JBarStore instance] adjustWeightForKg];
    [[JPlateStore instance] adjustForKg];
    self.calculator = [[BarCalculator alloc] initWithPlates:[[JPlateStore instance] findAll] barWeight:N(20)];
    NSArray *expected70 = @[@20, @5];
    STAssertEqualObjects([self.calculator platesToMakeWeight:N(70)], expected70, @"");
}

- (void)testFindPlateClosestToWeightMatch {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:N(45) count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:N(35) count:6];
    NSArray *plates = @[
            plate45,
            plate35
    ];

    PlateRemaining *p = [self.calculator findPlateClosestToWeight:N(100) fromPlates:plates];
    STAssertEquals(p, plate45, @"");
}

- (void)testFindPlateClosestToWeightMatchBelowTop {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:N(45) count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:N(35) count:6];
    PlateRemaining *plate25 = [[PlateRemaining alloc] initWithWeight:N(25) count:6];
    NSArray *plates = @[
            plate45,
            plate35,
            plate25
    ];

    PlateRemaining *p = [self.calculator findPlateClosestToWeight:N(60) fromPlates:plates];
    STAssertEquals(p, plate25, @"");
}

- (void)testFindPlateClosestToWeightNoMatch {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:N(45) count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:N(35) count:6];
    NSArray *plates = @[
            plate45,
            plate35
    ];

    PlateRemaining *p = [self.calculator findPlateClosestToWeight:N(25) fromPlates:plates];
    STAssertNil(p, @"");
}

@end