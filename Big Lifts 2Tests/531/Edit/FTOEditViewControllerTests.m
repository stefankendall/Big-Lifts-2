#import "FTOEditViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOEditViewController.h"
#import "NSArray+Enumerable.h"
#import "FTOLiftStore.h"
#import "LiftFormCell.h"
#import "FTOEditLiftCell.h"
#import "RowTextField.h"

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

- (void)testUpdatesTrainingMaxWhenWeightChanges {
    FTOEditLiftCell *cell =
            (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.max setText:@"200"];
    [self.controller textFieldDidEndEditing:cell.max];
    FTOEditLiftCell *updatedCell =
            (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([updatedCell.trainingWeight text], @"180", @"");
}

- (void)testHasAllLifts {
    NSMutableArray *lifts = [@[] mutableCopy];
    for (int i = 0; i < [[FTOLiftStore instance] count]; i++) {
        FTOEditLiftCell *cell = (FTOEditLiftCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [lifts addObject:cell.liftName.text];
    }
    [@[@"Squat", @"Deadlift", @"Press", @"Bench"] each:^(NSString *lift) {
        STAssertTrue([lifts containsObject:lift], @"");
    }];
}

@end