#import "FTOSSTLiftStoreTests.h"
#import "FTOSSTLiftStore.h"
#import "FTOSSTLift.h"

@implementation FTOSSTLiftStoreTests

-(void) testCreatesLiftsWithAssociation {
    STAssertEquals([[FTOSSTLiftStore instance] count], 4, @"");
    FTOSSTLift *lift = [[FTOSSTLiftStore instance] find: @"name" value: @"Front Squat"];
    STAssertEqualObjects(lift.associatedLift.name, @"Deadlift", @"");
}

@end