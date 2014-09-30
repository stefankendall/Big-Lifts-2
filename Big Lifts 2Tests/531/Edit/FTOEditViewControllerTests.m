#import "FTOEditViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOEditViewController.h"
#import "NSArray+Enumerable.h"
#import "JFTOLiftStore.h"
#import "LiftFormCell.h"
#import "FTOEditLiftCell.h"
#import "RowTextField.h"
#import "TrainingMaxRowTextField.h"
#import "JFTOLift.h"
#import "JFTOSettingsStore.h"

@interface FTOEditViewControllerTests ()

@property(nonatomic) FTOEditViewController *controller;
@end

@implementation FTOEditViewControllerTests

- (void)setUp {
    [super setUp];
    self.controller = [self getControllerByStoryboardIdentifier:@"ftoEdit"];
}

- (void)testHasCorrectRows {
    STAssertEquals((int) [self.controller tableView:nil numberOfRowsInSection:0], 4, @"");
}

- (void)testUpdatesTrainingMaxWhenWeightChanges {
    FTOEditLiftCell *cell =
            (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.max setText:@"200"];
    [self.controller textFieldDidEndEditing:cell.max];
    FTOEditLiftCell *newCell =
            (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([newCell.trainingMax text], @"180", @"");
}

- (void)testHandlesNilWeightDoesntCrash {
    JFTOLift *lift = [[JFTOLiftStore instance] create];
    lift.weight = nil;

    FTOEditLiftCell *cell =
            (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
}

- (void)testHandlesNanWeightDoesntCrash {
    JFTOLift *lift = [[JFTOLiftStore instance] create];
    lift.weight = [NSDecimalNumber notANumber];
    
    FTOEditLiftCell *cell =
    (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
}

- (void)testHandlesNilTrainingMaxDoesntCrash {
    [[[JFTOSettingsStore instance] first] setTrainingMax:nil];

    FTOEditLiftCell *cell =
            (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)testHandlesNanTrainingMaxDoesntCrash {
    [[[JFTOSettingsStore instance] first] setTrainingMax:[NSDecimalNumber notANumber]];
    
    FTOEditLiftCell *cell =
    (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)testEditTrainingMaxUpdatesMax {
    FTOEditLiftCell *cell =
            (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.trainingMax setText:@"105"];
    [self.controller textFieldDidEndEditing:cell.trainingMax];
    FTOEditLiftCell *newCell =
            (FTOEditLiftCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([newCell.max text], @"116.7", @"");
    STAssertEqualObjects([newCell.trainingMax text], @"105", @"");
}

- (void)testHasAllLifts {
    NSMutableArray *lifts = [@[] mutableCopy];
    for (int i = 0; i < [[JFTOLiftStore instance] count]; i++) {
        FTOEditLiftCell *cell = (FTOEditLiftCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [lifts addObject:cell.liftName.text];
    }
    [@[@"Squat", @"Deadlift", @"Press", @"Bench"] each:^(NSString *lift) {
        STAssertTrue([lifts containsObject:lift], @"");
    }];
}

@end