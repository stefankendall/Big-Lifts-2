#import "JWorkoutLogStoreTests.h"
#import "JWorkoutLogStore.h"

@implementation JWorkoutLogStoreTests

- (void)testRestoresBackupOnLoad {
    [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    [[JWorkoutLogStore instance] onLoad];
    [[JWorkoutLogStore instance] empty];
    [[JWorkoutLogStore instance] onLoad];

    STAssertEquals([[JWorkoutLogStore instance] count], 1, @"");
}

@end