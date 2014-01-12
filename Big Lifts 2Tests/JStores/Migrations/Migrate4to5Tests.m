#import "Migrate4to5Tests.h"
#import "JFTOSettingsStore.h"
#import "FTOEditLiftCell.h"
#import "Migrate4to5.h"

@implementation Migrate4to5Tests

- (void)testRemovesNilTrainingMax {
    [[[JFTOSettingsStore instance] first] setTrainingMax:nil];
    [[Migrate4to5 new] run];
    STAssertEqualObjects([[[JFTOSettingsStore instance] first] trainingMax], N(90), @"");
}

@end