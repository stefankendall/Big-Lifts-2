#import "FTOEditViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOEditViewController.h"
#import "LiftFormCellHelper.h"
#import "NSArray+Enumerable.h"
#import "FTOLiftStore.h"

@interface FTOEditViewControllerTests ()

@property(nonatomic) FTOEditViewController *controller;
@end

@implementation FTOEditViewControllerTests

- (void)setUp {
    [super setUp];
    self.controller = [self getControllerByStoryboardIdentifier:@"ftoEdit"];
}

- (void)testHasCorrectRows {
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:0], 4, @"");
}

- (void)testHasAllLifts {
    NSArray *lifts = [LiftFormCellHelper getLiftNamesFromCells:self.controller count:[[FTOLiftStore instance] count]];
    [@[@"Squat", @"Deadlift", @"Press", @"Bench"] each:^(NSString *lift) {
        STAssertTrue([lifts containsObject:lift], @"");
    }];
}

@end