#import "FTOSSTLiftStoreTests.h"
#import "FTOSSTLiftStore.h"
#import "FTOSSTLift.h"
#import "FTOLiftStore.h"

@implementation FTOSSTLiftStoreTests

- (void)testCreatesLiftsWithAssociation {
    STAssertEquals([[FTOSSTLiftStore instance] count], 4, @"");
    FTOSSTLift *lift = [[FTOSSTLiftStore instance] find:@"name" value:@"Front Squat"];
    STAssertEqualObjects(lift.associatedLift.name, @"Deadlift", @"");
}

- (void)testRemovesSstLiftsWhenFtoLiftsRemoved {
    FTOLift *deadlift = [[FTOLiftStore instance] find:@"name" value:@"Deadlift"];
    [[FTOLiftStore instance] remove:deadlift];
    [[FTOSSTLiftStore instance] adjustSstLiftsToMainLifts];

    STAssertEquals([[FTOSSTLiftStore instance] count], 3, @"");
}

- (void)testAddsSstLiftsForNewFtoLifts {
    FTOLift *overheadSquat = [[FTOLiftStore instance] create];
    overheadSquat.name = @"Overhead Squat";
    [[FTOSSTLiftStore instance] adjustSstLiftsToMainLifts];

    STAssertEquals([[FTOSSTLiftStore instance] count], 5, @"");
}

@end